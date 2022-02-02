//
//  Extensions.swift
//  UnsplashPhotosApp
//
//  Created by Ahmed on 30/01/22.
//

import Foundation



import SwiftUI



extension UINavigationController {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = nil
    }
}
