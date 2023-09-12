//
//  LoginViewController.swift
//  UnsplashProject
//
//  Created by 마르 on 2023/09/12.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet var idTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var loginButton: UIButton!
    
    var viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.addTarget(self, action: #selector(loginButtonClicked), for: .touchUpInside)
        idTextField.addTarget(self, action: #selector(idTextFieldChanged), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(pwTextFieldChanged), for: .editingChanged)
        
        viewModel.id.bind { text in
            self.idTextField.text = text
        }
        
        viewModel.pw.bind { text in
            self.passwordTextField.text = text
        }
        
        viewModel.isValid.bind{ bool in
            self.loginButton.isEnabled = bool
            self.loginButton.backgroundColor = bool ? .systemBlue : .lightGray
        }
        
    }
    
    @objc func idTextFieldChanged() {
        print("==")
        viewModel.id.value = idTextField.text! // 데이터가 바뀌었네 -> bind 구문 실행해야지!
        viewModel.checkValidation() // 데이터가 바뀌면 -> bind 구문 실행됨 
    }
    
    @objc func pwTextFieldChanged() {
        viewModel.pw.value = passwordTextField.text!
        viewModel.checkValidation()
    }
    
    @objc func loginButtonClicked() {
        
        viewModel.signIn {
            print("로그인 성공") // 로그인 실패 경우 고려할 필요 없이 그냥 얼럿 띄우기
        }
    }
}
