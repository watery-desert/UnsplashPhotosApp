//
//  HomeView.swift
//  UnsplashPhotosApp
//
//  Created by Ahmed on 25/01/22.
//

import SwiftUI

struct HomeView: View {
    

    
    var body: some View {
        NavigationView {
            RecentPhotosView()
            .navigationTitle("Home")
            .toolbar {
              
                ToolbarItem(placement: ToolbarItemPlacement.navigationBarTrailing) {
                    NavigationLink {
                        SearchPhotosView()
                    } label: {
                        Image(systemName: "magnifyingglass")
                    }

                }
            }
            .font(.system(size: 18))
        }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}


