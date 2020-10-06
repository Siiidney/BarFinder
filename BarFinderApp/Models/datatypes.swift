//
//  datatypes.swift
//  BarFinder
//
//  Created by Sinan Korcelik on 09/06/2020.
//  Copyright © 2020 Sinan Korcelik. All rights reserved.
//
import Foundation
import SwiftUI

//Seperate model class for setting all of the variable types and storing them into a datatype collection
//Data list used for Going Out Mode
struct BarData : Identifiable { //BarData
    
    var id : String
    var title : String
    var image : String
    var desc : String
    var location : String
    var info1 : String
    var info2 : String
    var swipe : CGFloat
    var degree : Double
}

//Data list used for Liked Bars list
struct LikedData : Identifiable {
    
    var title : String
    var location : String
    var image : String
    var id  : String
}

//Menu list
var data = ["Home", "Profile", "History", "Friends", "Settings", "Bars Near Me"]
