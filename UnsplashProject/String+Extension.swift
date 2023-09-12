//
//  String+Extension.swift
//  UnsplashProject
//
//  Created by 마르 on 2023/09/11.
//

import Foundation

extension String {
    
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    func localized(number: Int) -> String {
        return String(format: self.localized, number)
    }
}

//
//nicknameTextField.placeholder = NSLocalizedString("nickname_placeholder", comment: "")
//
//let value = NSLocalizedString("nickname_result", comment: "")
//resultLabel.text = String(format: value, "고래밥")
