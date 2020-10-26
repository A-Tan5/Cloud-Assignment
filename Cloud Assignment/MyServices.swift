//
//  MoyaServices.swift
//  Cloud Assignment
//
//  Created by tantsunsin on 2020/10/21.
//

import Foundation
import Moya

enum MyServices : TargetType{
    case downloadPhoto
    case downloadImage(URLString: String)
    
    var baseURL: URL{
        switch self {
        case .downloadPhoto:
            return URL(string: "https://jsonplaceholder.typicode.com")!
        case .downloadImage(let url):
            return URL(string: url)!
        }
    }
    
    var path: String{
        switch self {
        case .downloadPhoto:
            return "/photos"
        default:
            return ""
        }
    }
    
    var method: Moya.Method{
        return .get
    }
    
    var sampleData: Data{
        return Data()
    }
    
    var task: Task{
        return .requestPlain
    }
    
    var headers: [String : String]?{
        return nil
    }
    
    
}

