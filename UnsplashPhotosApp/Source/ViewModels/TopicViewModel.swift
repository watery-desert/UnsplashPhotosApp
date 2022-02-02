//
//  TopicViewModel.swift
//  UnsplashPhotosApp
//
//  Created by Ahmed on 29/01/22.
//

import Foundation
import Combine


class TopicViewModel: ObservableObject {
    
    enum State {
        case loading
        case loaded([Topic])
        case failed(Error)
    }
    
    @Published private(set) var state = State.loading
    private var cancellable = Set<AnyCancellable>()

    init() {
        loadTopics()
    }
    
    
    func loadTopics() {
        guard let url = URL(string: "https://api.unsplash.com/topics?client_id=\(accessKey)")
        else {
            state = .failed(URLError(URLError.badURL))
            return
        }
        
        let photosService = PhotosService<Topic>(url)
        
        photosService.getData()
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error):
                    guard let self = self else {return}
                    self.state = .failed(error)
                    print("Error is \(error)")
                case .finished: break
                }
            } receiveValue: { [weak self] data in
                guard let self = self else {return}
                self.state = .loaded(data)
            }
            .store(in: &cancellable)
    }
}
