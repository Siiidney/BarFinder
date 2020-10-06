//
//  LikedBars.swift
//  BarFinder
//
//  Created by Sinan Korcelik on 11/06/2020.
//  Copyright © 2020 Sinan Korcelik. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI
import Firebase

//Class for the users liked bars
struct LikedBars: View {
    
    @ObservedObject var datas = observer1()
    
    var body: some View {
        
        VStack{
            
            //If list is selected and no bars have been provided input, list will be empty
            if datas.data.isEmpty{
                
                Text("No Liked Bars")
            }
                
            else{
                //If list is populated, will display their title and image
                List(datas.data){i in
                    
                    cards(title: i.title, image: i.image)
                }
            }
        }
        
    }
}

struct cards : View {
    
    var title = ""
    var image = ""
    var location = ""
    var body : some View{
        
        HStack{
            //Retrieving bar that is liked and fetches the image, along with name and location
            AnimatedImage(url: URL(string: image)!).resizable().frame(width: 65, height: 65).clipShape(Circle())
            
            Text(title).fontWeight(.heavy)
            Text(location).fontWeight(.heavy)
        }
    }
}

//Class to make a new table of liked bars
class observer1 : ObservableObject{
    
    @Published var data = [LikedData]()
    
    init() {
        //Connects to the database
        let db = Firestore.firestore()
        db.collection("liked").getDocuments { (snap, err) in //Identifies the liked bars in the database
            
            if err != nil{
                //Error handling
                print((err?.localizedDescription)!)
                return
            }
            
            for i in snap!.documents{
                //Assigning the variables to their current variables and fetches them as a string
                let title = i.get("title") as! String
                let location = i.get("location") as! String
                let image = i.get("image") as! String
                
                self.data.append(LikedData(title: title, location: location, image: image, id: UUID().uuidString))
            }
        }
    }
}
