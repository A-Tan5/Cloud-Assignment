//
//  ImageViewModel.swift
//  Cloud Assignment
//
//  Created by tantsunsin on 2020/10/21.
//

import Foundation
import Moya
import UIKit

class PhotoViewModel{
    let photoForShow : Photo
    init (Photo: Photo){
        self.photoForShow = Photo
    }
    
    var id : String{
        return String(photoForShow.id ?? 0)
    }
    
    var title : String{
        return photoForShow.title ?? ""
    }
    
    var thumbnailUrl : String{
        return photoForShow.thumbnailUrl ?? ""
    }
    
    let imageCache = NSCache<NSURL, UIImage>()
    var service = MoyaProvider<MyServices>()
    

    
    
    func getImage(urlString: String, completionHandler : @escaping (UIImage?)->()){
     
        if let imageFromCache = imageCache.object(forKey: URL(string: urlString)! as NSURL){
            completionHandler(imageFromCache)
            return
        }
        
        service.request(.downloadImage(URLString: urlString)) { (result) in
            switch result{
            case .success(let response):
                let data = response.data
                if let imageGot = UIImage(data: data){
                    DispatchQueue.main.async {
                        
                        completionHandler(imageGot)
                        self.imageCache.setObject(imageGot, forKey: URL(string: urlString)! as NSURL)
                    }
                }
            case .failure:
                print ("載入圖片出錯！")
                let imageOfError = UIImage(named: "Error")
                completionHandler(imageOfError)
            }
        }
    }

    

}
