//
//  TopView.swift
//  BarFinder
//
//  Created by Sinan Korcelik on 10/06/2020.
//  Copyright © 2020 Sinan Korcelik. All rights reserved.
//

import SwiftUI

//Top view of the Going Out Mode
struct TopView : View {
    
    @Binding var show : Bool
    
    var body : some View{
        
        HStack{
            
            Button(action: {
                
                // Toggle to show menu button
                withAnimation(.spring()) {
                    
                }
            }) {
                
                Image("menu").resizable().frame(width: 35, height: 35)
                
            }.foregroundColor(.gray)
            
            
            Spacer()
            
            Spacer()
            
            Button(action: {
                //Toggle to show liked bars button
                self.show.toggle()
                
            }) {
                
                Image("tick").resizable().frame(width: 35, height: 35)
                
            }.foregroundColor(.gray)
            
   
        }.padding()
        
    }
    
    
    
}
