//
//  TouchdownApp.swift
//  Touchdown
//
//  Created by Thomas Mani on 20/09/23.
//

import SwiftUI

@main
struct TouchdownApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(Shop())
        }
    }
}
