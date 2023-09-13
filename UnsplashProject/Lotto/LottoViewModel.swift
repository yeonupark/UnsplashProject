//
//  LottoViewModel.swift
//  UnsplashProject
//
//  Created by 마르 on 2023/09/13.
//

import Foundation

class LottoViewModel {
    
    var turn: LottoObservable<String?>  = LottoObservable("")
    
    var number1: LottoObservable<String?> = LottoObservable("")
    var number2: LottoObservable<String?> = LottoObservable("")
    var number3: LottoObservable<String?> = LottoObservable("")
    var number4: LottoObservable<String?> = LottoObservable("")
    var number5: LottoObservable<String?> = LottoObservable("")
    var number6: LottoObservable<String?> = LottoObservable("")
    var number7: LottoObservable<String?> = LottoObservable("")
//    var luckyNumer : LottoObservable<String?>  = LottoObservable("")
    
    var date: LottoObservable<String?> = LottoObservable("")
    var money = LottoObservable("")
    
    func format(for number: Int) -> String {
        let numberFormat = NumberFormatter()
        numberFormat.numberStyle = .decimal
        return numberFormat.string(for: number)!
    }
    
    func fetchData() {
        guard let num = Int(turn.value ?? "") else {
            for item in [number1, number2, number3, number4, number5, number6, number7, date] {
                item.value = ""
            }
            money.value = "숫자를 입력해주세요."
            return
            
        }
        LottoAPIManager.shared.callLotto(num: num) { [self] lotto in
            
            guard let lotto = lotto else {
                for item in [number1, number2, number3, number4, number5, number6, number7, date] {
                    item.value = ""
                }
                self.money.value = "유효하지 않은 로또 회차입니다."
                return
            }
            
            self.number1.value = "\(lotto.drwtNo1) "
            self.number2.value = "\(lotto.drwtNo2) "
            self.number3.value = "\(lotto.drwtNo3) "
            self.number4.value = "\(lotto.drwtNo4) "
            self.number5.value = "\(lotto.drwtNo5) "
            self.number6.value = "\(lotto.drwtNo6) "
            self.number7.value = "\(lotto.bnusNo) "
            self.money.value = "\(self.format(for: lotto.totSellamnt))원"
            self.date.value = lotto.drwNoDate
        }
    }
    
}
