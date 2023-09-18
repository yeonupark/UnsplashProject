//
//  LottoObservable.swift
//  UnsplashProject
//
//  Created by 마르 on 2023/09/13.
//
import Foundation

class LottoObservable<T> {
    
    private var listener: ((T) -> Void)?
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(_ closure: @escaping (T) -> Void ) {
        //print(#function)
        closure(value)
        listener = closure
    }
}
