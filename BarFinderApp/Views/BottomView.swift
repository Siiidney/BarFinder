//
//  BottomView.swift
//  BarFinder
//
//  Created by Sinan Korcelik on 10/06/2020.
//  Copyright © 2020 Sinan Korcelik. All rights reserved.
//

import SwiftUI

//Bottom part of the Going Out Mode view
struct BottomView : View {
    
    @EnvironmentObject var obs : Observer
    
    var body : some View{
        
        HStack{
            //reload previous bar, resetting database preference
            Button(action: {
                
                if self.obs.last != -1{
                    //Updates database to remove the preference on the last bar given input and redisplay it
                    self.obs.updateDB(id: self.obs.bars[self.obs.last], preference: "")
                }
                
            }) {
                
                Image("reload").resizable().frame(width: 25, height: 25).padding()
                
            }.foregroundColor(.black)
                .background(Color.white)
                .shadow(radius: 25)
                .clipShape(Circle())
            
            //disliked bars - alternative from swiping
            Button(action: {
                 
                if self.obs.last == -1{
                    //Checking current bar in the view and updates the preference
                    self.obs.updateDB(id: self.obs.bars[self.obs.bars.count - 1], preference: "disliked")
                }
                else{
                   //Checking previous bar, comparing it to the current bar ensuring overlapping does not happen
                    self.obs.updateDB(id: self.obs.bars[self.obs.last - 1], preference: "disliked")
                    
                }
                
            }) {
                
                Image("clear").resizable().frame(width: 30, height: 30).padding()
                
            }.foregroundColor(.pink)
                .background(Color.white)
                .shadow(radius: 25)
                .clipShape(Circle())
            
            
            
            //like a bar - alternative from swiping
            Button(action: {
                
                if self.obs.last == -1{
                    
                    //Checking current bar in the view and updates the preference
                    self.obs.updateDB(id: self.obs.bars[self.obs.bars.count - 1], preference: "liked")
                }
                else{
                    
                   //Checking previous bar, comparing it to the current bar ensuring overlapping does not happen
                    self.obs.updateDB(id: self.obs.bars[self.obs.last - 1], preference: "liked")
                    
                }
                
            }) {
                
                Image("heart").resizable().frame(width: 35, height: 35).padding()
                
            }.foregroundColor(.green)
                .background(Color.white)
                .shadow(radius: 25)
                .clipShape(Circle())
            
            //More Info - Placeholder
            Button(action: {
                
                //self.MoreInfoShow.toggle()
                
            }) {
                
                Image("info").resizable().frame(width: 35, height: 35).padding()
                
            }.foregroundColor(.black)
                .background(Color.white)
                .shadow(radius: 25)
                .clipShape(Circle())
        }
    }
}
