//
//  Observable.swift
//  UnsplashProject
//
//  Created by 마르 on 2023/09/12.
//

import Foundation

// 양방향 데이터 구축해줌
class Observable<T> {
    
    private var listener: ((T) -> Void)?
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    } // 선언과 초기화가 바로 되어있지 않다면 이니셜라이저 만들어주기
    
    func bind(_ closure: @escaping (T) -> Void ) {
        print(#function)
        closure(value)
        listener = closure
    }
}
