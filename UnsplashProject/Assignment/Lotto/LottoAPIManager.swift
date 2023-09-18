//
//  LottoAPIManager.swift
//  UnsplashProject
//
//  Created by 마르 on 2023/09/13.
//

import Foundation
import Alamofire

class LottoAPIManager {
    
    static let shared = LottoAPIManager() // 타입 프로퍼티로 생성
    
    func callLotto(num: Int, completionHandler: @escaping (Lotto?) -> Void) {
        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(num)"
        
        AF.request(url, method: .get).validate()
            .responseDecodable(of: Lotto.self) { response in
                guard let value = response.value else {
                    completionHandler(nil)
                    return
                }
                
                completionHandler(value)
            }
    }
    
}
