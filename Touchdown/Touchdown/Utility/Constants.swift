//
//  Constants.swift
//  Touchdown
//
//  Created by Thomas Mani on 20/09/23.
//

import SwiftUI

//DATA
let categories : [Category] = Bundle.main.decode("category.json")
let players : [Player] = Bundle.main.decode("player.json")
let products : [Product] = Bundle.main.decode("product.json")
let brands : [Brand] = Bundle.main.decode("brand.json")
let sampleProduct : Product = products[0]
//COLOR
let colorBackground:Color = Color("ColorBackground")
let colorGray:Color = Color(UIColor.systemGray4)
//LAYOUT

let columnSpacing:CGFloat = 10
let rowSpacing:CGFloat = 10
var gridLayout:[GridItem] {
    Array(repeating: GridItem(.flexible(),spacing: rowSpacing), count: 2)
}
//UX
//API
//IMAGE
//FONT
//STRING
//MISC
