//
//  NetflixViewController.swift
//  UnsplashProject
//
//  Created by 마르 on 2023/09/18.

import UIKit
import SnapKit

class NetflixViewController: UIViewController {
    
    let signUpReadyLabel = {
        let view = UILabel()
        view.text = " 회원가입을 위해 정보를 모두 입력해주세요. "
        view.textColor = .systemBlue
        view.backgroundColor = .white
        view.textAlignment = .center
        view.font = .systemFont(ofSize: 12)
        
        return view
    }()
    
    let logoLabel = {
        let view = UILabel()
        view.text = "NETFLIX"
        view.textColor = .red
        view.font = .boldSystemFont(ofSize: 30)
        view.textAlignment = .center
        
        return view
    }()
    
    let emailTextField = {
        let view = SignUpTextField()
        view.placeholder = "이메일 주소 또는 전화번호"
        return view
    }()
    
    let passwordTextField = {
        let view = SignUpTextField()
        view.placeholder = "비밀번호"
        return view
    }()
    
    let nicknameTextField = {
        let view = SignUpTextField()
        view.placeholder = "닉네임"
        return view
    }()
    
    let locationTextField = {
        let view = SignUpTextField()
        view.placeholder = "위치"
        return view
    }()
    let codeTextField = {
        let view = SignUpTextField()
        view.placeholder = "추천 코드 입력"
        return view
    }()
    let signUpButton = {
        let view = UIButton()
        view.backgroundColor = .white
        view.setTitle("회원가입", for: .normal)
        view.setTitleColor(.black, for: .normal)
        view.titleLabel?.font = .boldSystemFont(ofSize: 16)
        view.layer.cornerRadius = 10
        
        return view
    }()
    
    let moreInfoLabel = {
        let view = UILabel()
        view.text = "추가 정보 입력"
        view.textColor = .white
        view.font = .systemFont(ofSize: 16)
        
        return view
    }()
    
    let switchControl = {
        let view = UISwitch()
        view.onTintColor = .systemRed
        view.isOn = true
        
        return view
    }()
    
    let viewModel = NetflixViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        for item in [logoLabel, emailTextField, passwordTextField, nicknameTextField, locationTextField, codeTextField, signUpButton, moreInfoLabel, switchControl, signUpReadyLabel] {
            view.addSubview(item)
        }
        
        setConstraints()
        closeKeyborad()
        
        viewModel.message.bind { message in
            self.signUpReadyLabel.text = message
        }
        viewModel.email.bind { email in
            self.emailTextField.text = email
        }
        viewModel.nickname.bind { nickname in
            self.nicknameTextField.text = nickname
        }
        viewModel.location.bind { location in
            self.locationTextField.text = location
        }
        viewModel.inviteCode.bind { code in
            self.codeTextField.text = code
        }
        
        for item in [emailTextField, nicknameTextField, passwordTextField, locationTextField, codeTextField] {
            item.addTarget(self, action: #selector(userInputChanged), for: .editingChanged)
        }
        
        signUpButton.addTarget(self, action: #selector(signUpButtonClicked), for: .touchUpInside)
        signUpButton.isEnabled = false
    }
    
    @objc func userInputChanged() {
        viewModel.email.value = emailTextField.text
        viewModel.pw.value = passwordTextField.text
        viewModel.nickname.value = nicknameTextField.text
        viewModel.location.value = locationTextField.text
        viewModel.inviteCode.value = codeTextField.text
        
        if viewModel.checkSignUpReady() {
            signUpButton.isEnabled = true
        } else {
            signUpButton.isEnabled = false
        }
    }
    
    func setConstraints() {
        
        logoLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(100)
            make.horizontalEdges.equalToSuperview().inset(80)
            make.height.equalTo(100)
        }
        
        let list = [emailTextField, passwordTextField, nicknameTextField, locationTextField, codeTextField, signUpButton]
        
        for i in 0...list.count-1 {
            list[i].snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.horizontalEdges.equalToSuperview().inset(40)
                make.top.equalToSuperview().inset(240 + i * 60)
                
                let length = i == list.count-1 ? 50 : 40
                make.height.equalTo(length)
            }
        }
        
        moreInfoLabel.snp.makeConstraints { make in
            make.top.equalTo(signUpButton.snp.bottom).offset(10)
            make.leading.equalToSuperview().inset(40)
            make.width.equalTo(100)
            make.height.equalTo(40)
        }
        
        switchControl.snp.makeConstraints { make in
            make.top.equalTo(signUpButton.snp.bottom).offset(10)
            make.trailing.equalToSuperview().inset(40)
            make.width.equalTo(50)
            make.height.equalTo(40)
        }
        
        signUpReadyLabel.snp.makeConstraints { make in
            //make.bottom.equalTo(emailTextField.snp.top).offset(100)
            make.top.equalToSuperview().inset(200)
            make.trailing.equalToSuperview().inset(40)
            make.height.equalTo(30)
        }
    }
    
    @objc func signUpButtonClicked() {
        
        let alert = UIAlertController(title: "\(viewModel.nickname.value ?? "회원")님, 환영합니다!", message: "회원가입이 완료되었습니다.", preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default)
        alert.addAction(ok)
        present(alert,animated: true)

    }
}

extension UIViewController {
    func closeKeyborad() {
         let tapEvent = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
         tapEvent.cancelsTouchesInView = false
         view.addGestureRecognizer(tapEvent)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}


class SignUpTextField: UITextField {
     
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpView() {
        backgroundColor = .lightGray
        layer.cornerRadius = 10
        textColor = .black
        textAlignment = .center
        font = .systemFont(ofSize: 15)
        
    }
}
