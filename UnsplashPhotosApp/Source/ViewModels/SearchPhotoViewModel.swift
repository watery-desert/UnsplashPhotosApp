//
//  SearchPhotoViewModel.swift
//  UnsplashPhotosApp
//
//  Created by Ahmed on 28/01/22.
//

import Foundation
import Combine



class SearchPhotoViewModel : ObservableObject {
    
    enum State {
        case initial
        case loading
        case loaded([Photo])
        case failed(Error)
    }
    
    
    @Published private(set) var state = State.initial
    @Published private(set) var hasReachedEnd: Bool = false
    private var queryText: String = ""
    private var allPhotos: [Photo] = []
    private var currentIndex: Int = 1
    private var cancellable = Set<AnyCancellable>()
    
    func searchPicture(_ query: String) {

        if query != queryText {
            state =  .loading
            queryText = query
            allPhotos = []
            hasReachedEnd = false
            currentIndex = 1
        } else if hasReachedEnd {
            return
        }
        
        let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)

        guard
            let encodedQuery = encodedQuery,
            let url = URL(string: "https://api.unsplash.com/search/photos/?client_id=\(accessKey)&page=\(currentIndex)&query=\(encodedQuery)")
        else {
            state = .failed(URLError(URLError.badURL))
            return
        }
        let photoService = PhotoService<QueryPhoto>(url)
        
        photoService.getData()
            .sink { [weak self]  completion in
                switch completion {
                case .failure(let error):
                    guard let self = self else {return}
                    self.state = .failed(error)
                    print("Error is \(error)")
                case .finished: break
                }
            } receiveValue: { [weak self] queryPhotos in
                guard let self = self else {return}
                if queryPhotos.totalPages == 0 {
                    self.allPhotos = []
                    self.state = .loaded(self.allPhotos)
                } else if  self.currentIndex <= queryPhotos.totalPages {
                    self.allPhotos.append(contentsOf: queryPhotos.photos)
                    self.state = .loaded(self.allPhotos)
                    self.currentIndex = self.currentIndex + 1
                } else {
                    self.hasReachedEnd = true
                }
            }
            .store(in: &cancellable)
    }
}


