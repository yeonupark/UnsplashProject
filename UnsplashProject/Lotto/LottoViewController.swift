//
//  LottoViewController.swift
//  UnsplashProject
//
//  Created by 마르 on 2023/09/13.
//

import UIKit

class LottoViewController: UIViewController {

    @IBOutlet var turnTextField: UITextField!
    @IBOutlet var dateLabel: UILabel!
    
    @IBOutlet var num1Label: UILabel!
    @IBOutlet var num2Label: UILabel!
    @IBOutlet var num3Label: UILabel!
    @IBOutlet var num4Label: UILabel!
    @IBOutlet var num5Label: UILabel!
    @IBOutlet var num6Label: UILabel!
    @IBOutlet var num7Label: UILabel!
    
    @IBOutlet var prizeLabel: UILabel!
    
    let viewModel = LottoViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()

        turnTextField.addTarget(self, action: #selector(turnTextFieldChanged), for: .editingChanged)
        
        viewModel.turn.bind { num in
            self.turnTextField.text = num
        }
        viewModel.money.bind { num in
            self.prizeLabel.text = num
        }
        viewModel.date.bind { date in
            self.dateLabel.text = date
        }
        
        viewModel.number1.bind { num in
            self.num1Label.text = num
        }
        viewModel.number2.bind { num in
            self.num2Label.text = num
        }
        viewModel.number3.bind { num in
            self.num3Label.text = num
        }
        viewModel.number4.bind { num in
            self.num4Label.text = num
        }
        viewModel.number5.bind { num in
            self.num5Label.text = num
        }
        viewModel.number6.bind { num in
            self.num6Label.text = num
        }
        viewModel.number7.bind { num in
            self.num7Label.text = num
        }
        
        turnTextField.placeholder = "로또 회차를 입력해주세요."
    }
    
    @objc func turnTextFieldChanged() {
        viewModel.turn.value = turnTextField.text
        viewModel.fetchData()
    }

}
