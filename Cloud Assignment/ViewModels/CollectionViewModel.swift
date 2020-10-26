//
//  CollectionViewModel.swift
//  Cloud Assignment
//
//  Created by tantsunsin on 2020/10/21.
//

import Foundation
import Moya
import UIKit

class CollectionViewModel {
    let service = MoyaProvider<MyServices>()
    var PhotoViewModels : [PhotoViewModel] = []


    func getPhotos(completionHandler : @escaping ()->()){
        PhotoViewModels = []
        service.request(.downloadPhoto) { (result) in
            switch result{
            case .success(let response):
                let data = response.data
                let PhotosResponded = try? JSONDecoder().decode([Photo].self, from: data)
                guard let Photos = PhotosResponded else{return}
                completionHandler()
                self.convertPhotoToViewModel(Photos: Photos)
                photos = Photos


            case .failure(let error):
                print ("ERROR: \(error)")
            }
        }
    }
    
    func convertPhotoToViewModel(Photos : [Photo]){
        for Photo in Photos{
            let viewModel = PhotoViewModel(Photo: Photo)
            PhotoViewModels.append(viewModel)
        }
    }
    
    
}
