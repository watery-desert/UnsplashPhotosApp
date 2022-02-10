//
//  QueryWallpaper.swift
//  UnsplashPhotosApp
//
//  Created by Ahmed on 30/01/22.
//

import Foundation


class QueryPhoto: Codable {
    let total: Int
    let totalPages: Int
    let photos: [Photo]
    
    enum CodingKeys: String, CodingKey {
        case total
        case totalPages = "total_pages"
        case photos = "results"
    }
    
}
