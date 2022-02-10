//
//  RecentPhotosView.swift
//  UnsplashPhotosApp
//
//  Created by Ahmed on 25/01/22.
//

import SwiftUI

struct RecentPhotosView: View {
    
    @StateObject private var photoViewModel: PhotoViewModel = PhotoViewModel()

    
    var body: some View {
        
        ZStack {
            Color("Background")
                .ignoresSafeArea()
            
            switch photoViewModel.state {
            case .loading:
                LoadingView()
            case .loaded(let photos):
                            
                ScrollView {
                    heading("Topics")
                    
                    TopicRow()
                    heading("Recent Pictures")
                    StaggeredPhotosView(photos) { photo in
                        
                            guard let lastPhoto = photos.last else {return }
                            if lastPhoto.id == photo.id {
                                photoViewModel.loadPhotos()
                            }
                    }
                    .padding([.horizontal], 16)
                }

            case .failed(let error):
                ErrorView(error: "\(error.localizedDescription)")
            }
        }
            
    }
    
    private func heading(_ text: String) -> some View {
        Text(text)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(16)
            .font(.system(size: 18, weight: .bold))
    }
    
}


struct RecentPhotosView_Previews: PreviewProvider {
    static var previews: some View {
        RecentPhotosView()
    }
}









