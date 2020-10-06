//
//  Observer.swift
//  BarFinder
//
//  Created by Sinan Korcelik on 10/06/2020.
//  Copyright © 2020 Sinan Korcelik. All rights reserved.
//

import SwiftUI
import Firebase
import SDWebImageSwiftUI

//Class for talking between views and models alongside fetching from database
class Observer : ObservableObject{
    
    @Published var bars = [BarData]()
    @Published var last = -1
    
    //Initiatizes the connection to database
    init() {
        //Calls the database and sets it to local variable db
        let db = Firestore.firestore()
        //Database calls the collection(table) bars and retrieves the documents from them
        db.collection("bars").getDocuments { (snap, err) in
            //Error handling
            if err != nil{
                //Prints to console if there's error with database
                print((err?.localizedDescription)!)
                return
            }
            //If there are contents in the retrevial, it will identify them
            for i in snap!.documents{
                //Assigns each of the fields in the table as Strings and stores them at local variables
                let title = i.get("title") as! String
                let location = i.get("location") as! String
                let image = i.get("image") as! String
                let info1 = i.get("info1") as! String
                let info2 = i.get("info2") as! String
                let desc = i.get("desc") as! String
                let id = i.documentID
                let preference = i.get("preference") as! String
                
                //If the current preference is empty
                if preference == ""{
                    //The following get appended from the array
                    self.bars.append(BarData(id: id, title: title, image: image, desc: desc, location: location, info1: info1, info2: info2, swipe: 0, degree: 0))
                    
                }
                
            }
        }
    }
    
    func update(id : BarData,value : CGFloat,degree : Double){
        
        for i in 0..<self.bars.count{
            
            if self.bars[i].id == id.id{
                
                self.bars[i].swipe = value
                self.bars[i].degree = degree
                self.last = i
            }
        }
    }
    
    
    func updateDB(id : BarData,preference : String){
        
        let db = Firestore.firestore()
        
        db.collection("bars").document(id.id).updateData(["preference":preference]) { (err) in
            
            if err != nil{
                
                print(err!.localizedDescription)
                return
            }
            
            print("Preference Given")
            
            for i in 0..<self.bars.count{
                
                if self.bars[i].id == id.id{
                    
                    if preference == "liked"{
                        
                        self.bars[i].swipe = 500
                    }
                    else if preference == "disliked"{
                        
                        self.bars[i].swipe = -500
                    }
                    else{
                        
                        self.bars[i].swipe = 0
                    }
                }
            }
            //making table
            if preference == "liked"{
                
                db.collection("liked").document(id.id).setData(["title":id.title,"location":id.location,"image":id.image]) { (err) in
                    
                    if err != nil{
                        
                        print((err?.localizedDescription)!)
                        return
                    }
                }
            }
            
            if preference == ""{
                
                db.collection("liked").document(id.id).delete { (err) in
                    
                    if err != nil{
                        
                        print((err?.localizedDescription)!)
                        return
                    }
                }
            }
            
        }
    }
    
}

