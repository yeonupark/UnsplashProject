//
//  PhotoViewModel.swift
//  UnsplashProject
//
//  Created by 마르 on 2023/09/12.
//

import Foundation
// 뷰모델 - uikit 임포트하지 않는다!

class PhotoViewModel {
    
    // observable - 데이터가 바뀔 때 마다 항상 캐치해서 처리해줌
    var photoList = Observable(Photo(total: 0, total_pages: 0, results: []))
    
    func fetchPhoto() {
        
        PhotoAPIService.shared.searchPhoto(query: "cat") { photo in
            guard let photo = photo else {
                return
            }
            self.photoList.value = photo
            
        }
    }
    
    var numberOfRowsInSection: Int {
        return photoList.value.results?.count ?? 0
    }
    
    func cellForRowAt(at indexPath: IndexPath) -> PhotoResult {
        return photoList.value.results![indexPath.row]
    }
    
}
