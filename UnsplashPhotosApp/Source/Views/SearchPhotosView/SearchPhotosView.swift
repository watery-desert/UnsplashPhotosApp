//
//  SearchPhotosView.swift
//  UnsplashPhotosApp
//
//  Created by Ahmed on 28/01/22.
//

import SwiftUI

struct SearchPhotosView: View {
    
    
    @StateObject private var searchPhotoViewModel: SearchPhotoViewModel = SearchPhotoViewModel()
    @State private var textFieldText = ""
    @FocusState private var textFieldFocus: Bool

    var body: some View {
        ZStack {
            Color("Background")
                .ignoresSafeArea()
            
            VStack(spacing: 0.0) {
                    TextField("Type anything", text: $textFieldText)
                        .focused($textFieldFocus)
                        .padding()
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .shadow(color: .black.opacity(0.15), radius: 2.0, x: 1.0, y: 1.0)
                        .padding([.horizontal , .top], 16)
                       
                        
                
                switch searchPhotoViewModel.state {
                case .initial:
                    VStack {
                        Spacer()
                        Image("Search")
                            .resizable()
                            .scaledToFit()
                        Spacer()
                    }
             

                case .loading:
                    LoadingView()

                case .loaded(let photos):
                    
                    if photos.isEmpty {
                        VStack{
                            Spacer()
                            Text("😞 Sad nothing found")
                            Spacer()
                        }
                    } else  {
                        ScrollView {
                            StaggeredPhotosView(photos) { photo in
                                
                                    guard let lastPhoto = photos.last else {return }
                                    if lastPhoto.id == photo.id {
                                        searchPhotoViewModel.searchPicture(textFieldText)
                                    }
                            }
                            .padding([.horizontal, .top], 16)
                        }
                    }
                    
                    
                   
                case .failed(let error):
                    ErrorView(error: "\(error.localizedDescription)")
                }
            }
            .ignoresSafeArea(.keyboard)
        }
        .navigationTitle("Search")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: ToolbarItemPlacement.keyboard) {
                Button("Done") {
                    textFieldFocus = false
                    searchPhotoViewModel.searchPicture(textFieldText)
                }

            }
        }
        
    }
}

struct SearchPhotosView_Previews: PreviewProvider {
    static var previews: some View {
        SearchPhotosView()
    }
}
