//
//  SimpleCollectionViewController.swift
//  UnsplashProject
//
//  Created by 마르 on 2023/09/14.
//

import UIKit
import SnapKit

//private let reuseIdentifier = "Cell"

class SimpleViewModel {
    
    let list1: Observable<[User]> = Observable([])
    var list2 = [User(name: "기생충", age: 2019), User(name: "스파이더맨", age: 2023), User(name: "겨울왕국", age: 2010), User(name: "인셉션", age: 2007)]
    
    func append() {
        list1.value = [User(name: "Hue", age: 23), User(name: "Hue", age: 23), User(name: "Bran", age: 20), User(name: "Kokojong", age: 20)]
    }
    
    func remove() {
        list1.value = []
    }
    
    func removeUser(idx: Int) {
        list1.value.remove(at: idx)
    }
    
    func insertUser(name: String) {
        let user = User(name: name, age: Int.random(in: 19...35))
        list1.value.insert(user, at: Int.random(in: 0...2))
    }
}

class SimpleCollectionViewController: UIViewController {
    
    enum Section: Int, CaseIterable {
        case movie = 2000
        case actor = 1
    }
    
    var viewModel = SimpleViewModel()

    var collectionView = UICollectionView(frame: CGRect(), collectionViewLayout: createLayout())
    
    var dataSource: UICollectionViewDiffableDataSource<String, User>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let searchBar = UISearchBar()
        searchBar.delegate = self
        navigationItem.titleView = searchBar
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        configureDataSource()
        
        //updateSnapshot()
        viewModel.list1.bind { user in
            self.updateSnapshot() // 데이터 달라질 때 마다 컬렉션뷰 갱신 해줘
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.viewModel.append()
            //self.list1.insert(User(name: "연준", age: 23), at: 2)
            self.updateSnapshot()
        }
        
        collectionView.delegate = self
        
    }
    
    func updateSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<String, User>()
        
        snapshot.appendSections(["영화","사람"])
        
        snapshot.appendItems(viewModel.list1.value, toSection: "사람")
        snapshot.appendItems(viewModel.list2, toSection: "영화")
        
        dataSource.apply(snapshot)
    }
    
    static private func createLayout() -> UICollectionViewLayout {
        var configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        configuration.showsSeparators = false
        configuration.backgroundColor = .black
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        return layout
    }
    
    private func configureDataSource() {
        
        // UICollectionView.CellRegistration -> iOS 14 이상, 메서드 대신 제네릭을 사용, 셀이 생성될 때마다 클로저가 호출됨 !
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, User>(handler: { cell, indexPath, itemIdentifier in
            
            // 셀 디자인 및 데이터 처리
            //var content = cell.defaultContentConfiguration()
            var content = UIListContentConfiguration.valueCell()
            content.text = itemIdentifier.name
            content.textProperties.font = .boldSystemFont(ofSize: 15)
            content.secondaryText = "\(itemIdentifier.age)"
            content.image = UIImage(systemName: "star")
            content.imageProperties.tintColor = .systemPink
            // content.prefersSideBySideTextAndSecondaryText = false
            content.textToSecondaryTextVerticalPadding = 10
            cell.contentConfiguration = content
            
            var backgroundConfig = UIBackgroundConfiguration.listPlainCell()
            backgroundConfig.backgroundColor = .lightGray
            backgroundConfig.cornerRadius = 10
            backgroundConfig.strokeWidth = 2
            backgroundConfig.strokeColor = .systemPink
            cell.backgroundConfiguration = backgroundConfig
            
        })
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            
            // cellForItamAt
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            return cell
        })
    }
}

extension SimpleCollectionViewController: UICollectionViewDelegate, UISearchBarDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //let user = viewModel.list1.value[indexPath.item] 대신
        guard let user = dataSource.itemIdentifier(for: indexPath) else {
            return
        }
        dump(user) // print로 하나하나 요소 점 찍어서 가져오지 않아도 됨
        self.viewModel.removeUser(idx: indexPath.item)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.insertUser(name: searchBar.text ?? "짱구")
    }
}
