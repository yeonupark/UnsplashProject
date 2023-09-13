//
//  CaculateViewController.swift
//  UnsplashProject
//
//  Created by 마르 on 2023/09/13.
//

import UIKit

class CaculateViewController: UIViewController {

    @IBOutlet var firstTextField: UITextField!
    @IBOutlet var secondTextField: UITextField!
    @IBOutlet var resultLabel: UILabel!
    @IBOutlet var tempLabel: UILabel!
    
    let viewModel = CalculateViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstTextField.addTarget(self, action: #selector(firstTextFieldChanged), for: .editingChanged)
        secondTextField.addTarget(self, action: #selector(secondTextFieldChanged), for: .editingChanged)
        
        viewModel.firstNumber.bind { num in
            self.firstTextField.text = num
            print("firstnumber changed \(num)")
        }
        viewModel.secondNumber.bind { num in
            self.secondTextField.text = num
            print("secondnumber changed \(num)")
        }
        viewModel.resultText.bind { text in
            self.resultLabel.text = text
        }
        viewModel.tempText.bind { text in
            self.tempLabel.text = text
        }
        
    }
    
    @objc func firstTextFieldChanged() {
        viewModel.firstNumber.value = firstTextField.text
        viewModel.calculate()
        viewModel.presentNumberFormat()
    }
    
    @objc func secondTextFieldChanged() {
        viewModel.secondNumber.value = secondTextField.text
        viewModel.calculate()
    }

}

/*
let person = Person("새싹이")
person.name = "싹"
person.name = "새싹"

person.introduce { value in
    self.resultLabel.text = value
    self.view.backgroundColor = [UIColor.systemPink, UIColor.orange, UIColor.brown].randomElement()!
}

DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
    person.name = "연우"
    print(" 2초 뒤 !!")
}

DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
    person.name = "태민"
    print(" 3초 뒤 !!")
}

firstTextField.text = viewModel.firstNumber.value
secondTextField.text = viewModel.secondNumber.value
*/
