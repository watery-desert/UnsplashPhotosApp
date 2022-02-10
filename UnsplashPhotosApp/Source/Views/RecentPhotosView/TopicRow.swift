//
//  TopicRow.swift
//  UnsplashPhotosApp
//
//  Created by Ahmed on 29/01/22.
//

import SwiftUI

struct TopicRow: View {
    @StateObject private var topicViewModel: TopicViewModel = TopicViewModel()

    
    var body: some View {
        
        switch topicViewModel.state {
            
        case .loading:
            Text("Loading")
        case .loaded(let topics):
            ScrollView(.horizontal, showsIndicators: false ) {
                
                HStack(spacing: 16) {
                    ForEach(topics) { topic in
                        ZStack {
                           buildImageView("\(topic.coverPhoto.urls.thumb)")
                            Text("\(topic.title)")
                                .foregroundColor(.white)
                                .font(.system(size: 20,weight: .bold))
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                    }
                    
                }
                .padding(.horizontal, 16)
            }
        case .failed:
            
            Image(systemName: "exclamationmark.triangle")
            
        }
        
    }
        
    private func buildImageView(_ url: String) -> some View {
        AsyncImage(url: URL(string: url)) { imagePhase in
            switch imagePhase {
            case .empty:
                Color.gray
                    .frame(height: 80)
            case .failure:
                Image(systemName:  "exclamationmark.triangle")
            case .success(let image):
                image
            @unknown default:
                fatalError()
            }
        }
        .overlay(.black.opacity(0.2))
        .frame( maxHeight: 80)
    }
    
}

struct TopicRow_Previews: PreviewProvider {
    static var previews: some View {
        TopicRow()
    }
}
