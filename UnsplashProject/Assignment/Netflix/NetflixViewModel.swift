//
//  NetflixViewModel.swift
//  UnsplashProject
//
//  Created by 마르 on 2023/09/18.
//

import Foundation

class NetflixViewModel {
    var message = Observable("회원가입을 위해 정보를 모두 입력해주세요.")
    var email: Observable<String?> = Observable("")
    var pw: Observable<String?> = Observable("")
    var nickname: Observable<String?> = Observable("")
    var location: Observable<String?> = Observable("")
    var inviteCode: Observable<String?> = Observable("")
    
    func checkSignUpReady() -> Bool {
        
        if !email.value!.contains("@") {
            message.value = "이메일은 반드시 @를 포함해야합니다."
            return false
        }
        if (pw.value!.count < 6) || (pw.value!.count > 10) {
            message.value = "비밀번호는 6자리 이상, 10자리 이상으로 설정해주세요."
            return false
        }
        if nickname.value!.isEmpty {
            message.value = "닉네임을 입력해주세요."
            return false
        }
        if location.value!.isEmpty {
            message.value = "위치를 입력해주세요."
            return false
        }
        guard let code = Int(inviteCode.value!) else {
            message.value = "추천코드는 숫자로만 이루어져 있습니다."
            return false
        }
        if String(code).count != 6 {
            message.value = "추천코드는 6자리 입니다."
            return false
        }
        
        message.value = "모든 정보를 입력하셨습니다. 회원가입 버튼을 눌러주세요!"
        return true
    }
    
    
}
