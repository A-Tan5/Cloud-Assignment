//
//  Photo.swift
//  Cloud Assignment
//
//  Created by tantsunsin on 2020/10/21.
//

import Foundation
import UIKit

struct Photo: Codable {
    var id : Int?
    var title : String?
    var thumbnailUrl : String?
    
    enum CodingKeys: CodingKey {
            case id, title, thumbnailUrl
        }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id)
        title = try container.decodeIfPresent(String.self, forKey: .title)
        thumbnailUrl = try container.decodeIfPresent(String.self, forKey: .thumbnailUrl)
    }
}

var photos : [Photo]?

