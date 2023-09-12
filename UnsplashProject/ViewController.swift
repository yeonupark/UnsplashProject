//
//  ViewController.swift
//  UnsplashProject
//
//  Created by 마르 on 2023/09/11.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var nicknameTextField: UITextField!
    @IBOutlet var changeButton: UIButton!
    @IBOutlet var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nicknameTextField.placeholder = "nickname_placeholder".localized
        
        //let value = NSLocalizedString("nickname_result", comment: "")
        //resultLabel.text = String(format: value, "고래밥")
        resultLabel.text = "age_result".localized
        
        // cmd ctrl e
        let searchBar1 = UISearchBar()
        searchBar1.text = "ssss"
        searchBar1.placeholder = "Asefg"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(#function)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print(#function)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(#function)
    }
}

