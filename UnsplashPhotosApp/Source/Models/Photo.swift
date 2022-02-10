//
//  Photo.swift
//  UnsplashPhotosApp
//
//  Created by Ahmed on 25/01/22.
//

import SwiftUI



struct Photo: Identifiable, Codable {
    let id: String
    let description: String?
    let urls: Urls
    let links: Links

    enum CodingKeys: String, CodingKey {
        case id
        case description
        case urls
        case links
    }
}


struct Links: Codable {
    let downloadLocation: String
    
    enum CodingKeys: String, CodingKey {
        case downloadLocation = "download_location"
    }
}

