//
//  StaggeredPhotosView.swift
//  UnsplashPhotosApp
//
//  Created by Ahmed on 01/02/22.
//

import SwiftUI


struct StaggeredPhotosView: View {
    
    let photos: [Photo]
    let onTileCallback: ((Photo) -> Void)?
    
    
    init(_ pictures: [Photo], onTileAppear: ((Photo) -> Void)? = nil) {
        self.photos = pictures
        self.onTileCallback = onTileAppear
    }
    

    
    
    private var splitArray: [[Photo]] {
        var result: [[Photo]] = []
        
        var list1: [Photo] = []
        var list2: [Photo] = []
        
        photos.forEach { photo in
            let index = photos.firstIndex {$0.id == photo.id }
            
            if let index = index {
                if index % 2 == 0  {
                    list1.append(photo)
                } else {
                    list2.append(photo)
                }
            }
        }
        result.append(list1)
        result.append(list2)
        return result
        
    }
    
    var body: some View {

        HStack(alignment: .top) {
            
            
            LazyVStack(spacing: 8) {
                ForEach(splitArray[0]) { photo in
                PhotoTile(photo: photo)
                        .onAppear(perform: {onAppearClosure(photo)})

                }
            }
            
            LazyVStack(spacing: 8) {
                ForEach(splitArray[1]) { photo in
                    PhotoTile(photo: photo)
                            .onAppear(perform: {onAppearClosure(photo)})
                        
                    }
            }
        }
    }
    
    func onAppearClosure(_ photo: Photo) {
        guard let onTileCallback = onTileCallback else {
            return
        }
        onTileCallback(photo)
    }
    
}
