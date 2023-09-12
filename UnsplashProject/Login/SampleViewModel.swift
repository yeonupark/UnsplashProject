//
//  SampleViewModel.swift
//  UnsplashProject
//
//  Created by 마르 on 2023/09/12.
//

import Foundation
// ViewModel - viewcontroller의 기능을 일부 담당해줌. ui랑 관련 없는 연산 과정은 뷰모델이 처리함 (비지니스 로직)

class SampleViewModel {
    
    var list = [User(name: "Hue", age: 23), User(name: "Jack", age: 21), User(name: "Bran", age: 20), User(name: "Kokojong", age: 20)]
    
    var numberOfRowsInSection: Int {
        return list.count
    }
    
    func cellForRowAt(at indexPath: IndexPath) -> User {
        return list[indexPath.row]
    }
}
