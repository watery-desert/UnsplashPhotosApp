//
//  DownloadPhotoViewModel.swift
//  UnsplashPhotosApp
//
//  Created by Ahmed on 01/02/22.
//

import Foundation
import Combine
import UIKit

class DownloadPhotoViewModel: ObservableObject {
    
    
    private var cancellable = Set<AnyCancellable>()
    @Published private(set) var state = State.idle

    
    enum State {
        case idle
        case loading
        case loaded
        case failed
    }
    
    
    func downloadPhoto(_ url: String) {
        state = .loading
        guard let url = URL(string: "\(url)?client_id=\(accessKey)")
        else {
            state = .failed
            return
        }
        
        let photoService = APIService<DownloadPhoto>(url)
        
        photoService.getData()
            .sink { [weak self]  completion in
                switch completion {
                case .failure(let error):
                    guard let self = self else {return}
                    self.state = .failed
                    print("Error is \(error)")
                case .finished: break
                }
            } receiveValue: { [weak self] downloaded in
                
                guard let self = self else { return }
                self.getData(downloaded.url) { data in
                    
                    if  let uiImage = UIImage(data: data) {
                        let imageSaver = ImageSaver()
                        imageSaver.writeToPhotoAlbum(image: uiImage)
                        self.state = .loaded
                    } else {
                        self.state = .failed
                    }
                }
            }
            .store(in: &cancellable)
    }
    
    
      private func getData(_ url: String, receiveCallback: @escaping (Data) -> Void) {
         guard let url = URL(string: url) else {return}
         URLSession.shared.dataTaskPublisher(for: url)
            .receive(on: DispatchQueue.main)
            .map{$0.data}
            .sink { _ in
            } receiveValue: { data in
                receiveCallback(data)
            }
            .store(in: &cancellable)
    }
}
