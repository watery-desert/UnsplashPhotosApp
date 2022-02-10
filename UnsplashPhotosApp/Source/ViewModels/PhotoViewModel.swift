//
//  PhotoViewModel.swift
//  UnsplashPhotosApp
//
//  Created by Ahmed on 26/01/22.
//
import Combine
import Foundation

class PhotoViewModel : ObservableObject {
    
    enum State {
        case loading
        case loaded([Photo])
        case failed(Error)
    }
    
    
    @Published private(set) var state = State.loading
    private var currentIndex = 1
    private var cancellable = Set<AnyCancellable>()
    private var allPhotos: [Photo] = []

    init() {
        loadPhotos()
    }
    
    func loadPhotos() {
        
        guard let url = URL(string: "https://api.unsplash.com/photos/?client_id=\(accessKey)&page=\(currentIndex)&content_filter=high")
        else {
            state = .failed(URLError(URLError.badURL))
            return
        }
        
        let photosService = APIService<[Photo]>(url)
 
        photosService.getData()
            .delay(for: 0.8, scheduler: RunLoop.main)
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error):
                    guard let self = self else {return}
                    self.state = .failed(error)
                case .finished: break   
                }
            }
            receiveValue: { [weak self] receivedPhotos in
                guard let self = self else {return}
                self.allPhotos.append(contentsOf: receivedPhotos)
                self.state = .loaded(self.allPhotos)
                self.currentIndex = self.currentIndex + 1
            }
            .store(in: &cancellable)
    }
}




