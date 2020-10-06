//
//  Loader.swift
//  BarFinder
//
//  Created by Sinan Korcelik on 09/06/2020.
//  Copyright © 2020 Sinan Korcelik. All rights reserved.
//

import SwiftUI

// Framework used to reduce the gap between launch and loading the view with the bars
// Reference: https://github.com/SDWebImage/SDWebImageSwiftUI
// Loading animation  if the bars list is empty or is waiting to fetch the data from the database
struct Loader : UIViewRepresentable {
    
    func makeUIView(context: UIViewRepresentableContext<Loader>) -> UIActivityIndicatorView {
        //Calling the user interface to display the loading icon with an animated effect to load whilst view is empty
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.startAnimating()
        return indicator
    }
    //Once content has loaded, will update the view and replace loader with the content (Going Out Mode)
    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<Loader>) {
        
        
    }
}
