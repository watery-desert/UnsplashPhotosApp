//
//  PhotoService.swift
//  UnsplashPhotosApp
//
//  Created by Ahmed on 02/02/22.
//

import Foundation
import Combine

class PhotoService<T: Codable> {
    let url: URL
    
    init(_ url :URL) {
        self.url = url
    }
    
    func getData() -> AnyPublisher<T, Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .receive(on: DispatchQueue.main)
            .map{$0.data}
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
