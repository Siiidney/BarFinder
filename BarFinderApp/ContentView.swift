 //
 //  ContentView.swift
 //  BarFinder
 //
 //  Created by Sinan Korcelik on 09/06/2020.
 //  Copyright © 2020 Sinan Korcelik. All rights reserved.
 //
 
 import SwiftUI
 import MapKit
 
 //Main Content view, first view to be visible
 struct GoingOutMode: View {
    
    //Setting state of the buttons
    @State var index = "Home"
    @State var show = false
    
    var body: some View {
        
        ZStack{
            
            (self.show ? Color.black.opacity(0.05) : Color.clear).edgesIgnoringSafeArea(.all)
            
            ZStack(alignment: .leading)
            {
                
                VStack(alignment : .leading,spacing: 25)
                {
                    //Placeholder data, acting as user account
                    HStack(spacing: 15)
                    {
                        
                        Image("pic")
                            .resizable()
                            .frame(width: 65, height: 65)
                        
                        VStack(alignment: .leading, spacing: 12)
                        {
                            
                            Text("Sid")
                                .fontWeight(.bold)
                            
                            Text("London, UK")
                        }
                    }
                    .padding(.bottom, 50)
                    
                    //Dyamically populating menu
                    ForEach(data, id: \.self){i in
                        
                        Button(action: {
                            
                            self.index = i
                            //animation effect
                            withAnimation(.spring()){
                                
                                self.show.toggle()
                            }
                            
                        }) {
                            
                            HStack{
                                //Current menu tab is coloured and rest are clear
                                Capsule()
                                    .fill(self.index == i ? Color.blue : Color.clear)
                                    .frame(width: 5, height: 30)
                                
                                Text(i)
                                    .padding(.leading)
                                    .foregroundColor(.black)
                                
                            }
                        }
                    }
                    
                    Spacer()
                }.padding(.leading)
                    .padding(.top)
                    .scaleEffect(self.show ? 1 : 0)
                
                ZStack(alignment: .topTrailing) {
                    //Scaling of the current view is altered depending if menu is open or closed
                    MainView(show: self.$show,index: self.$index)
                        .scaleEffect(self.show ? 0.8 : 1)
                        .offset(x: self.show ? 150 : 0,y : self.show ? 50 : 0)
                        .disabled(self.show ? true : false)
                    
                    
                    Button(action: {
                        
                        withAnimation(.spring()){
                            
                            self.show.toggle()
                        }
                        
                    }) {
                        //Closing the menu
                        Image(systemName: "xmark")
                            .resizable()
                            .frame(width: 15, height: 15)
                            .foregroundColor(.black)
                        
                    }.padding()
                        .opacity(self.show ? 1 : 0)
                }
                
            }
        }
    }
 }
 
 struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GoingOutMode()
    }
 }
 
 struct MainView : View {
    
    @Binding var show : Bool
    @Binding var index : String
    
    var body : some View{
        
        VStack(spacing: 0){
            
            ZStack{
                
                HStack{
                    //Clickable menu button
                    Button(action: {
                        
                        withAnimation(.spring()){
                            
                            self.show.toggle()
                        }
                        
                    }) {
                        
                        Image("Menu")
                            .resizable()
                            .frame(width: 20, height: 15)
                            .foregroundColor(.black)
                    }
                    
                    Spacer()
                    
                    
                }
                //BarFinder logo
                Image("BarFinderTitle").resizable().frame(width: 150, height: 50)
            }
            .padding(.horizontal)
            .padding(.vertical, 10)
            
            ZStack{
                //Calling the functions for each view to the menu
                Home().opacity(self.index == "Home" ? 1 : 0)
                
                Profile().opacity(self.index == "Profile" ? 1 : 0)
                
                History().opacity(self.index == "History" ? 1 : 0)
                
                Friends().opacity(self.index == "Friends" ? 1 : 0)
                
                Settings().opacity(self.index == "Settings" ? 1 : 0)
                
                BarsNearMe().opacity(self.index == "Bars Near Me" ? 1 : 0)
            }
            
        }.background(Color.white)
            .cornerRadius(15)
    }
 }
 
//Going Out Mode view
 struct Home : View {
    
    @EnvironmentObject var obs : Observer
    @State var showLiked = false
    @State var viewMenu = false
    @State var viewMoreInfo = false
    @State var viewMainView = false
    @State var ratings = 0
    @State var show = false
    
    var body: some View {
        
        ZStack{
            
            Color("LightBK").edgesIgnoringSafeArea(.all)
            
            if obs.bars.isEmpty{
                //Loading animation function called while data loads onto view
                Loader()
            }
            //Combintation of top, middle and bottom views onto the going out mode
            VStack{
                //Top view, passing the liked bars into list
                TopView(show: $showLiked)
                //Core of going out mode, calls the swiping functions
                SwipeView()
                //Rating a bar button
                Button(action: {
                    self.ratings = 0
                    self.show.toggle()
                    
                }) {
                    //Image of alcohol/liquid here
                    Text("Review Bar").fontWeight(.bold).foregroundColor(.black).offset(x: 150)
                   
                }
                
                if self.ratings != 0 {
                    //Displaying the users choice on the bar
                    Text("Personal Bar Rating : \(self.ratings)/5").fontWeight(.bold).foregroundColor(.black).padding(.top, 25)
                    
                }
                
                if self.show {
                    
                    GeometryReader{_ in
                        
                        VStack {
                            //Calling the function to fetch the values of the users choice
                            Feedback(ratings: self.$ratings, show: self.$show).padding()
                            
                        }
                    }.background(Color.black.opacity(0.2).edgesIgnoringSafeArea(.all))
                    
                }
                
                BottomView()
                
            }
            
        }.sheet(isPresented: $showLiked) {
            //Calling the list of liked bars
            LikedBars()
        }
    }
 }
 
 
 
 
 struct History : View {
    
    @State var ratings = 0
    @State var show = false
    
    var body : some View{
        
        GeometryReader{_ in
            
            VStack {
                
                Text("Bar History")
                Button(action: {
                    self.ratings = 0
                    self.show.toggle()
                    
                }) {
                    
                    Text("Review Bar").fontWeight(.bold).foregroundColor(.black)
                }
                
                if self.ratings != 0 {
                    
                    Text("Personal Bar Rating : \(self.ratings)/5").fontWeight(.bold).foregroundColor(.black).padding(.top, 25)
                    
                }
                
                
                
                if self.show {
                    
                    GeometryReader{_ in
                        
                        VStack {
                            
                            Feedback(ratings: self.$ratings, show: self.$show).padding()
                            
                        }
                    }.background(Color.black.opacity(0.2).edgesIgnoringSafeArea(.all))
                    
                }
            }
        }
    }
 }
 //Placeholder for Profile view
 struct Profile : View {
    
    var body : some View{
        
        GeometryReader{_ in
            
            VStack {
                
                Text("Profile")
            }
        }
    }
 }
  //Placeholder for Settings view
 struct Settings : View {
    
    var body : some View{
        
        GeometryReader{_ in
            
            VStack {
                
                Slider()
            }
        }
    }
 }
  //Placeholder for Friends view
 struct Friends : View {
    
    var body : some View{
        
        GeometryReader{_ in
            
            VStack {
                
                Text("Friends")
            }
        }
    }
 }
 //Slider for the settings view
 struct Slider : View {
    //Setting width of both movable points
    @State var width : CGFloat = 0
    @State var width1 : CGFloat = 15
    var totalWidth = UIScreen.main.bounds.width - 60
    
    var body : some View {
        
        VStack {
            
            Text("Bar Distance")
                .font(.title)
                .fontWeight(.bold)
            //Values displayed represent the number of both points
            Text("\(self.getValue(val: self.width / self.totalWidth)) - \(self.getValue(val: self.width1 / self.totalWidth))")
                .fontWeight(.bold)
                .padding(.top)
            
            
            ZStack(alignment: .leading) {
                Rectangle()//The axis the points are on
                    .fill(Color.black.opacity(0.20))
                    .frame(height: 6)
                Rectangle()
                    .fill(Color.black)//Area the points can be contained in
                    .frame(width: self.width1 - self.width, height: 6)
                    .offset(x: self.width + 18)
                HStack(spacing: 0) {
                    //First point, starting at the left side
                    Circle()
                        .fill(Color.black)
                        .frame(width: 18, height: 18)
                        .offset(x: self.width)
                        .gesture(
                            DragGesture()
                                .onChanged({ (value) in
                                    //Cannot go passed  the second point
                                    if value.location.x >= 0 && value.location.x <= self.width1 {
                                        
                                        self.width = value.location.x
                                    }
                                })
                    )//Second point, starting at the right side
                    Circle()
                        .fill(Color.black)
                        .frame(width: 18, height: 18)
                        .offset(x: self.width1)
                        .gesture(
                            DragGesture()
                                .onChanged({ (value) in
                                    //Cannot go passed the first point
                                    if value.location.x <= self.totalWidth && value.location.x >= self.width {
                                        
                                        self.width1 = value.location.x
                                    }
                                })
                    )
                }
            }
            .padding(.top, 25)
        }
        .padding()
        
    }
    //Values are collected from a float and converted to a string to display
    func getValue(val: CGFloat)->String{
        
        return String(format: "%.2f", val)
        
        
    }
 }
 //Class for the rating view
 struct Feedback : View {
    //Setting rating buttons
    @Binding var ratings : Int
    @Binding var show : Bool
    
    var body : some View {
        
        VStack {
            
            HStack {
                //Prompts user to rate the bar
                Text("Please rate the quality of this bar").fontWeight(. bold).foregroundColor(.white)
                
                Spacer()
                
            }.padding()
                .background(Color.green)
            
            VStack {
                //Choices the user can select for rating a bar, where text and colour will change depending on choice
                if self.ratings != 0 {
                    
                    if self.ratings == 5 {
                        
                        Text("Excellent").fontWeight(.bold).foregroundColor(.yellow)
                    }
                    else if self.ratings == 4 {
                        
                        Text("Great").fontWeight(.bold).foregroundColor(.green)
                    }
                        
                    else if self.ratings == 3 {
                        
                        Text("Good").fontWeight(.bold).foregroundColor(.green)
                        
                    }
                        
                    else if self.ratings == 2 {
                        
                        Text("Okay").fontWeight(.bold).foregroundColor(.blue)
                        
                    }
                        
                    else {
                        
                        Text("Horrendous").fontWeight(.bold).foregroundColor(.red)
                        
                    }
                    
                    
                }
                
            }.padding(.top, 20)
            
            HStack(spacing: 15) {
                //Displaying a star for each of the 5 choices the user can select
                ForEach(1...5,id: \.self) {i in
                    //Will fill the stars in when they areselected, along with the stars previous to that, displaying the rating out of 5
                    Image(systemName: self.ratings == 0 ? "star" : "star.fill").resizable().frame(width: 25, height: 25).foregroundColor(i <= self.ratings ? .green : Color.black.opacity(0.2))
                        .onTapGesture {
                            self.ratings = i
                    }
                }
                
            }.padding()
            
            HStack {
                
                Spacer()
                //Ratings are passed on pressing the button
                Button(action: {
                    
                    self.ratings = 0
                    self.show.toggle()
                    
                    
                }) {//Exiting the rating view
                    Text("Cancel").foregroundColor(.green).fontWeight(.bold)
                }
                
                Button(action: {
                    
                    self.show.toggle()
                    
                }) {//Submitting the view, returning back to the Going Out Mode where rating will now be displayed
                    Text("Submit").foregroundColor(self.ratings != 0 ? .green : Color.black.opacity(0.2)).fontWeight(.bold)
                }.padding(.leading, 20)
                    .disabled(self.ratings != 0 ? false : true)
                
            }.padding()
            
            
        }.padding()
            .background(Color.white)
            .cornerRadius(10 )
    }
 }
 //Exploration Mode view
 struct BarsNearMe: View {
    //Setting the buttons and passing objects into the function from other functions,
    //calling the current location and nearby bars
    @ObservedObject var locationManager = UserLocation()
    @State private var landmarks: [SocialSpot] = [SocialSpot]()
    @State private var search: String = "Bar"
    @State private var tapped: Bool = false
    
    //Fetching nearby bars using a function
    private func getNearByLandmarks() {
        
        //variable to request the nearby bars location
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = search
        
        //variable to "search" for the nearby bars location, performed via a button
        let search = MKLocalSearch(request: request)
        search.start { (response, error) in
            if let response = response {
                
                let mapItems = response.mapItems
                self.landmarks = mapItems.map {
                    SocialSpot(placemark: $0.placemark)
                }
                
            }
            
        }
        
    }
    //Calculating current screen on map, with how zoomed in/out the view is on the map
    func calculateOffset() -> CGFloat {
        //Once the nearby bars are fetched, will zoom in on current user location
        if self.landmarks.count > 0 && !self.tapped {
            return UIScreen.main.bounds.size.height - UIScreen.main.bounds.size.height / 4
        }
        else if self.tapped {
            return 100
        } else {
            return UIScreen.main.bounds.size.height
        }
    }
    //View of the Exploration Mode
    var body: some View {
        ZStack(alignment: .top) {
            //Displaying the map from calling function, passing nearby bars
            MapContent(landmarks: landmarks)
            
            Button(action: {
                self.getNearByLandmarks()
            })
            {   //Button to initiate the nearby bars being searched
                TextField("Search Bar", text: $search).accentColor(.clear)
            }.offset(x: 10, y: 620)
                .foregroundColor(.blue)
            //The list at the bottom of the map will be populated once the button is pressed,
            //fetching all the nearby bars in a list
            BarListView(landmarks: self.landmarks) {
                
                self.tapped.toggle()
            }.animation(.spring())
                .offset(y: calculateOffset())
            
        }
    }
 }
