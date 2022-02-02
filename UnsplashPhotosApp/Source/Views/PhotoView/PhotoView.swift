//
//  PhotoView.swift
//  UnsplashPhotosApp
//
//  Created by Ahmed on 30/01/22.
//

import SwiftUI

struct PhotoView: View {

    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>

    @StateObject private var downloadPhotoViewModel: DownloadPhotoViewModel = DownloadPhotoViewModel()
    
    let photo: Photo
    var body: some View {
        AsyncImage(url: URL(string: photo.urls.full)) { imagePhase in
            switch imagePhase {
            case .empty:
                ZStack {
                    Color.white
                        .ignoresSafeArea()
                    LoadingView()
                }
                    
            case .success(let image):
                ZStack {
                    Color.black
                        .ignoresSafeArea()
                    image
                        .resizable()
                        .aspectRatio( contentMode: .fit)
                    
                    VStack {
                        
                        HStack {
                            Button {
                                presentationMode.wrappedValue.dismiss()
                            } label: {
                                Image(systemName: "arrow.backward")
                                    .padding()
                            }
                            
                            Text(photo.description ?? "NO DESCRIPTION")
                            Spacer()
                        }
                        .font(.system(size: 18))
                 
                        Spacer()
                        Button {
                            print("\(photo.links.downloadLocation)")
                            downloadPhotoViewModel.downloadPhoto(photo.links.downloadLocation)
                        } label: {
                            getIcon(state: downloadPhotoViewModel.state)
                        }
                        .font(.headline)
                        .frame(maxWidth: 56, maxHeight: 56)
                        .background(getColor(state: downloadPhotoViewModel.state))
                        .cornerRadius(16)
                        .padding()
                    }
                    
                    .foregroundColor(.white)
                    
                }
            

            case .failure(let error):
                Text("\(error.localizedDescription)")
            @unknown default:
                fatalError()
            }
        }
        .navigationBarHidden(true)
    }
    
    @ViewBuilder
    func getIcon(state: DownloadPhotoViewModel.State) -> some View {
        switch state {
        case .idle:
             Image(systemName: "arrow.down")
        case .loading:
             ProgressView()
        case .failed:
             Image(systemName: "exclamationmark.circle")
        case .loaded:
             Image(systemName: "checkmark")
        }
    }
    
    func getColor(state: DownloadPhotoViewModel.State) -> Color {
        switch state {
        case .idle:
            return Color.gray
        case .loading:
            return Color.blue
        case .failed:
            return Color.red
            
        case .loaded:
            return Color.green
        }
    }
}

struct PhotoView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoView(photo: Photo(
            id: "1",
//            color: "#262626",
//            blurHash: "LzJPxUR+NIj@~AjZWWfQEls.s.az",
            description: "Flower in the sun",
            urls: Urls(
                raw: "https://images.unsplash.com/photo-1643472009925-b86e009e21a2?ixid=MnwyOTQ1MjZ8MHwxfGFsbHw0fHx8fHx8Mnx8MTY0MzU1ODQ4OA&ixlib=rb-1.2.1",
                full: "https://images.unsplash.com/photo-1643472009925-b86e009e21a2?crop=entropy&cs=srgb&fm=jpg&ixid=MnwyOTQ1MjZ8MHwxfGFsbHw0fHx8fHx8Mnx8MTY0MzU1ODQ4OA&ixlib=rb-1.2.1&q=85",
                regular: "https://images.unsplash.com/photo-1643472009925-b86e009e21a2?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwyOTQ1MjZ8MHwxfGFsbHw0fHx8fHx8Mnx8MTY0MzU1ODQ4OA&ixlib=rb-1.2.1&q=80&w=1080",
                small: "https://images.unsplash.com/photo-1643472009925-b86e009e21a2?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwyOTQ1MjZ8MHwxfGFsbHw0fHx8fHx8Mnx8MTY0MzU1ODQ4OA&ixlib=rb-1.2.1&q=80&w=400",
                thumb: "https://images.unsplash.com/photo-1643472009925-b86e009e21a2?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwyOTQ1MjZ8MHwxfGFsbHw0fHx8fHx8Mnx8MTY0MzU1ODQ4OA&ixlib=rb-1.2.1&q=80&w=200"
                
            ),
            links: Links(
                
//                selfLink: "https://api.unsplash.com/photos/rN1y-_EV8kE",
//                html: "https://unsplash.com/photos/rN1y-_EV8kE",
//                download: "https://unsplash.com/photos/rN1y-_EV8kE/download?ixid=MnwyOTQ1MjZ8MXwxfGFsbHwxfHx8fHx8Mnx8MTY0MzY5MjYxNg",
                downloadLocation: "https://api.unsplash.com/photos/rN1y-_EV8kE/download?ixid=MnwyOTQ1MjZ8MXwxfGFsbHwxfHx8fHx8Mnx8MTY0MzY5MjYxNg"
                
            )
          )
        )
    }
}



          

               

                     
