//
//  Cell.swift
//  loremipsum
//
//  Created by raj vaya on 29/01/22.
//

import Foundation


enum CellColor{
    
    case White
    case Green
    case Yellow
    case Black
    
    init() {
        self = .White
    }
}


enum KeyColor{
    case Grey
    case Green
    case Yellow
    case Black
    init() {
        self = .Grey
    }
}

struct Cell : Hashable {
    let id = UUID()
    var text : String = "";
    var cellColor: CellColor = CellColor.White;
    var isAnimated:Bool =  false;
    
    
}


struct Keys : Hashable{
    
    var text : String = "";
    var keyColor: KeyColor = KeyColor.Grey;
   
}
