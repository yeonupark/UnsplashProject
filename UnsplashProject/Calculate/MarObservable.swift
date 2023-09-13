//
//  MarObservable.swift
//  UnsplashProject
//
//  Created by 마르 on 2023/09/13.
//

import Foundation

class CustomObservable<T> {
    
    var listener: ((T) -> Void)? // luckyNum이랑 똑같다.
    
    var value: T {
        didSet { // 프로퍼티 바뀔 때 마다 감지
            listener?(value) //
            print("사용자의 이름이 \(value)(으)로 변경되었습니다.")
        }
    }
    
    init(_ name: T) {
        self.value = name
    }
    
    func bind(_ sample: @escaping (T) -> Void) {
        print("저는 \(value)입니다.")
        sample(value)
        listener = sample // 뷰컨에서 명시한 sample 함수를 리스너에 담아서 재사용 할 수 있도록 함
    }
    
}
