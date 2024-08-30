//
//  Product.swift
//  Touchdown
//
//  Created by Thomas Mani on 20/09/23.
//

import SwiftUI

struct Product:Codable,Identifiable{
    
    let id:Int
    let name:String
    let image:String
    let price:Int
    let description:String
    let color:[Double]
    
    var red:Double {color[0]}
    var green:Double {color[1]}
    var blue:Double {color[2]}
    var bgColor:Color {Color(red: red, green: green, blue: blue)}
    
    var formattedPrice:String {"$\(price)"}
}
