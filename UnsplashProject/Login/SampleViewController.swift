//
//  SampleViewController.swift
//  UnsplashProject
//
//  Created by 마르 on 2023/09/12.
//

import UIKit

struct User {
    let name: String
    let age: Int
    
    var introduce: String {
        return "\(name), \(age)살"
    }
}

class SampleViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    let viewModel = SampleViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var num1 = 10
        var num2 = 3
        print(num1 - num2)
        num1 = 3
        num2 = 1
        
        var num3 = Observable(10)
        var num4 = Observable(3)
        num3.bind { number in
            print("Observable", num3.value - num4.value)
        }
        
        num3.value = 100
        num3.value = 500
        num3.value = 50 // 모델의 데이터가 변경될 때 마다 프린트가 계속 실행됨 !! -> 양방향
        
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
}

extension SampleViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "sampleCell")!
        let data = viewModel.cellForRowAt(at: indexPath)
        cell.textLabel?.text = data.introduce
        
        return cell
    }
}
