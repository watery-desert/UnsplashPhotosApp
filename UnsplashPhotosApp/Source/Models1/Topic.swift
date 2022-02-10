//
//  Topic.swift
//  UnsplashPhotosApp
//
//  Created by Ahmed on 29/01/22.
//




struct Topic: Identifiable, Codable {
    
    let id: String
    let title: String
    let totalPhotos: Int
    let coverPhoto: CoverPhoto
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case totalPhotos = "total_photos"
        case coverPhoto = "cover_photo"
    }
    
}

// MARK: - CoverPhoto
struct CoverPhoto: Codable {
    let urls: Urls
}
