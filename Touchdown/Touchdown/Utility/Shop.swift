//
//  Shop.swift
//  Touchdown
//
//  Created by Thomas Mani on 21/09/23.
//

import Foundation

class Shop : ObservableObject {
    @Published var showingProduct:Bool = false
    @Published var selectedProduct:Product? = nil
}
