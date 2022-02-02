//
//  ErrorView.swift
//  UnsplashPhotosApp
//
//  Created by Ahmed on 27/01/22.
//

import SwiftUI

struct ErrorView: View {
    let error: String
    
    var body: some View {
        VStack {
            Spacer()
            Text(error)
            Spacer()
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(error: "Error")
    }
}
