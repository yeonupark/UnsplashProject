//
//  SimpleCollectionViewController.swift
//  UnsplashProject
//
//  Created by 마르 on 2023/09/14.
//

import UIKit
import SnapKit

private let reuseIdentifier = "Cell"

class SimpleCollectionViewController: UIViewController {
    
    enum Section: Int, CaseIterable {
        case movie = 2000
        case actor = 1
    }

    var list1 = [User(name: "Hue", age: 23), User(name: "Hue", age: 23), User(name: "Bran", age: 20), User(name: "Kokojong", age: 20)]
    var list2 = [User(name: "기생충", age: 2019), User(name: "스파이더맨", age: 2023), User(name: "겨울왕국", age: 2010), User(name: "인셉션", age: 2007)]
    
    var collectionView = UICollectionView(frame: CGRect(), collectionViewLayout: createLayout())
    
    var cellRegistration: UICollectionView.CellRegistration<UICollectionViewListCell, User>!
    
    var datasouce: UICollectionViewDiffableDataSource<String, User>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(collectionView)
//        collectionView.delegate = self
//        collectionView.dataSource = self
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        datasouce = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            
            // cellForItamAt
            let cell = collectionView.dequeueConfiguredReusableCell(using: self.cellRegistration, for: indexPath, item: itemIdentifier)
            return cell
        })
        
        // UICollectionView.CellRegistration -> iOS 14 이상, 메서드 대신 제네릭을 사용, 셀이 생성될 때마다 클로저가 호출됨 !
        cellRegistration = UICollectionView.CellRegistration(handler: { cell, indexPath, itemIdentifier in
            
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
        
        var snapshot = NSDiffableDataSourceSnapshot<String, User>()
        
        snapshot.appendSections(["영화","사람"])
        
        snapshot.appendItems(list1, toSection: "사람")
        snapshot.appendItems(list2, toSection: "영화")
        
        datasouce.apply(snapshot)
        
    }
    
    static func createLayout() -> UICollectionViewLayout {
        var configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        configuration.showsSeparators = false
        configuration.backgroundColor = .black
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        return layout
    }
}

/*
extension SimpleCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: list[indexPath.item])
        
        return cell
    }
}
*/
