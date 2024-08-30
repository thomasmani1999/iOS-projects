//
//  BlankView.swift
//  devote
//
//  Created by Thomas Mani on 25/09/23.
//

import SwiftUI

struct BlankView: View {
    
    var backgroundColor:Color
    var baclgroundopacity:Double
    
    var body: some View {
        VStack {
            Spacer()
        }
        .frame(minWidth: 0,idealWidth: 100,maxWidth: .infinity,minHeight: 0,maxHeight: .infinity ,alignment: .center)
        .background(backgroundColor)
        .opacity(baclgroundopacity)
        .blendMode(.overlay)
        .edgesIgnoringSafeArea(.all)
    }
}

struct BlankView_Previews: PreviewProvider {
    static var previews: some View {
        BlankView(backgroundColor: .black, baclgroundopacity: 0.3)
            .background(BackgroundImageView())
            .background(backgroundGradient.ignoresSafeArea(.all))
    }
}
