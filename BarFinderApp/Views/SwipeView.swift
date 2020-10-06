//
//  SwipeView.swift
//  BarFinder
//
//  Created by Sinan Korcelik on 11/06/2020.
//  Copyright © 2020 Sinan Korcelik. All rights reserved.
//

import SwiftUI

//The core of the going out mode, where user provides their preference
struct SwipeView : View {
    //Stating database and swiping mechanic objects into view
    @EnvironmentObject var obser : Observer
    @State var colorTap:Bool = false
    
    var body : some View{
        
        GeometryReader{geo in
            
            ZStack{
                
                //For each loop dynamically populating the card with the bars stored in the database
                ForEach(self.obser.bars){i in
                    
                    //Function to populate the card dynamically to each card, displaying a title, image and 2 short points
                    SwipeDetailsView(title: i.title, image: i.image, info1: i.info1, info2: i.info2, height: geo.size.height - 100).background(self.colorTap ? Color.green : Color.red).gesture(DragGesture()
                        //Green or Red background on if user likes or dislikes bar
                        
                        //As the user tilts the card either left or right
                        .onChanged({ (value) in
                            
                            //If the user tilts the card to like it
                            if value.translation.width > 0{
                                
                                self.obser.update(id: i, value: value.translation.width, degree: 8)
                                self.colorTap = true
                                
                            }
                            //If the user tilts the card to dislike it
                            else {
                                
                                self.obser.update(id: i, value: value.translation.width, degree: -8)
                                self.colorTap = false
                                
                            }
                            
                            //By fully swiping left or right with the card, preference is given
                        }).onEnded({ (value) in
                            
                            
                            if i.swipe > 0{
                                //Fully swiping right on the card, moving it off screen
                                if i.swipe > geo.size.width / 2 - 80{
                                    
                                    
                                    //liked a bar, sending preference to updateDB
                                    self.obser.update(id: i, value: 500, degree: 0)
                                    self.obser.updateDB(id: i, preference: "liked")
                                    
                                    
                                    
                                }
                                else{
                                    //Reoriginate card position
                                    self.obser.update(id: i, value: 0, degree: 0)
                                }
                            }
                            else{
                                //Fully swiping left on the card, moving it off screen
                                if -i.swipe > geo.size.width / 2 - 80{
                                    
                                    //disliked a bar, sending preference to updateDB
                                    self.obser.update(id: i, value: -500, degree: 0)
                                    self.obser.updateDB(id: i, preference: "disliked")
                                    
                                    
                                }
                                else{
                                    //Reoriginate card position
                                    self.obser.update(id: i, value: 0, degree: 0)
                                }
                            }
                            
                        })
                    ).offset(x: i.swipe)
                        .rotationEffect(.init(degrees: i.degree))
                        .animation(.spring())
                }
            }
        }
    }
}
