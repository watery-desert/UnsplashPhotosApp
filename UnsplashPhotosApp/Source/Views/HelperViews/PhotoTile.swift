//
//  PictureTile.swift
//  UnsplashPhotosApp
//
//  Created by Ahmed on 29/01/22.
//

import SwiftUI

struct PhotoTile: View {
    
    var photo: Photo
    private let deviceWidth = UIScreen.main.bounds.width
    @State private var isActive = false

    var body: some View {
    
        AsyncImage(url: URL(string: photo.urls.small)) { image in
            switch image {
            case .empty:
                ProgressView()
                    .frame(width: deviceWidth/2.0, height: 250)
            case .failure:
                
// issue with AsyncImage --> https://developer.apple.com/forums/thread/682498
                Image(systemName: "exclamationmark.triangle")
                    .padding()
                    .font(.largeTitle)
            case .success(let image):
                NavigationLink {
                    PhotoView(photo: photo)
                } label: {
                    image
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                }
                .buttonStyle(BouncyStyle())
            @unknown default:
                fatalError()
            }
        }
    }
}

struct PhotoTile_Previews: PreviewProvider {
    static var previews: some View {
        PhotoTile(photo:
                        
            Photo(
                id: "1",
//                color: "#262626",
//                blurHash: "LzJPxUR+NIj@~AjZWWfQEls.s.az",
                description: "Flower in the sun",
                urls: Urls(
                    raw: "https://images.unsplash.com/photo-1643472009925-b86e009e21a2?ixid=MnwyOTQ1MjZ8MHwxfGFsbHw0fHx8fHx8Mnx8MTY0MzU1ODQ4OA&ixlib=rb-1.2.1",
                    full: "https://images.unsplash.com/photo-1643472009925-b86e009e21a2?crop=entropy&cs=srgb&fm=jpg&ixid=MnwyOTQ1MjZ8MHwxfGFsbHw0fHx8fHx8Mnx8MTY0MzU1ODQ4OA&ixlib=rb-1.2.1&q=85",
                    regular: "https://images.unsplash.com/photo-1643472009925-b86e009e21a2?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwyOTQ1MjZ8MHwxfGFsbHw0fHx8fHx8Mnx8MTY0MzU1ODQ4OA&ixlib=rb-1.2.1&q=80&w=1080",
                    small: "https://images.unsplash.com/photo-1643472009925-b86e009e21a2?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwyOTQ1MjZ8MHwxfGFsbHw0fHx8fHx8Mnx8MTY0MzU1ODQ4OA&ixlib=rb-1.2.1&q=80&w=400",
                    thumb: "https://images.unsplash.com/photo-1643472009925-b86e009e21a2?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwyOTQ1MjZ8MHwxfGFsbHw0fHx8fHx8Mnx8MTY0MzU1ODQ4OA&ixlib=rb-1.2.1&q=80&w=200"
                    
                ),
                
                links: Links(
                    
//                    selfLink: "https://api.unsplash.com/photos/rN1y-_EV8kE",
//                    html: "https://unsplash.com/photos/rN1y-_EV8kE",
//                    download: "https://unsplash.com/photos/rN1y-_EV8kE/download?ixid=MnwyOTQ1MjZ8MXwxfGFsbHwxfHx8fHx8Mnx8MTY0MzY5MjYxNg",
                    downloadLocation: "https://api.unsplash.com/photos/rN1y-_EV8kE/download?ixid=MnwyOTQ1MjZ8MXwxfGFsbHwxfHx8fHx8Mnx8MTY0MzY5MjYxNg"
                    
                )
            )
        )
    }
}



private struct BouncyStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .scaleEffect(configuration.isPressed ? 0.9 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}
