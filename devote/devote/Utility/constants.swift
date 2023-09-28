//
//  constants.swift
//  devote
//
//  Created by Thomas Mani on 25/09/23.
//

import SwiftUI

let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

var backgroundGradient: LinearGradient {
    LinearGradient(gradient: .init(colors: [.pink,.blue]), startPoint: .topLeading, endPoint: .bottomTrailing)
}
