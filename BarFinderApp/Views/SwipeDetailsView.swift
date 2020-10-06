//
//  SwipeDetailsView.swift
//  BarFinder
//
//  Created by Sinan Korcelik on 11/06/2020.
//  Copyright © 2020 Sinan Korcelik. All rights reserved.
//

import SwiftUI
import Firebase
import SDWebImageSwiftUI

//Class for populating the card on the Going Out Mode
struct SwipeDetailsView : View {
    
    var title = ""
    var location = ""
    var image = ""
    var info1 = ""
    var info2 = ""
    var desc = ""
    var height : CGFloat = 0
    
    var body : some View {
        
        //Showing the contents on the view
        ZStack {
            
            AnimatedImage(url: URL(string: image)!).resizable().cornerRadius(20).padding(.horizontal, 15)
            
            VStack {
                
                Spacer()
                
                HStack {
                    //Adding the title and 2 short points about the bar to the card
                    VStack(alignment: .leading, content: {
                        
                        Text(title).font(.system(size: 25)).fontWeight(.heavy).foregroundColor(.white)
                        Text(info1).foregroundColor(.white)
                        Text(info2).foregroundColor(.white)
                        
                        
                    })
                    
                    Spacer()
                }
                
            }.padding([.bottom,.leading], 35)
            
        }.frame(height: height)
        
        
    }
    
}
