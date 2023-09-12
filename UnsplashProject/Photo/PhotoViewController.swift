//
//  PhotoViewController.swift
//  UnsplashProject
//
//  Created by 마르 on 2023/09/12.
//

import UIKit
// 뷰컨트롤러 - 뷰모델이 일한거 받아옴. UI적인 작업만 여기에서 실행

class PhotoViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    var viewModel = PhotoViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        viewModel.fetchPhoto()
        
        viewModel.photoList.bind { _ in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

extension PhotoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "photoCell")!
        
        let data = viewModel.cellForRowAt(at: indexPath)
        
        cell.backgroundColor = .systemPink
        
        return cell
    }
}





