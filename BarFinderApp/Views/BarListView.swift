//
//  PlaceListView.swift
//  BarFinder
//
//  Created by Sinan Korcelik on 09/06/2020.
//  Copyright © 2020 Sinan Korcelik. All rights reserved.
//

import SwiftUI
import MapKit

//Class for the nearby bars in list view
struct BarListView: View {
    
    //Fetches the landmarks that have been identified
    let landmarks: [SocialSpot]
    var onTap: () -> ()
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            HStack {
                //If list is empty
                EmptyView()
                
            }.frame(width: UIScreen.main.bounds.size.width, height: 60)
                .background(Color.gray)
                .gesture(TapGesture()
                    .onEnded(self.onTap)
            )
            
            List {
                //Dynamically fetching the nearby bars and populate them into the list
                ForEach(self.landmarks, id: \.id) { landmark in
                    //Identifies the name of type of social spot and displays its name
                    VStack(alignment: .leading) {
                        Text(landmark.name)
                            .fontWeight(.bold)
                        
                        Text(landmark.title)
                    }
                }
                
            }.animation(nil)
            
        }.cornerRadius(10)
    }
}

struct PlaceListView_Previews: PreviewProvider {
    static var previews: some View {
        BarListView(landmarks: [SocialSpot(placemark: MKPlacemark())], onTap: {})
    }
}

