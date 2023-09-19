//
//  HeadingView.swift
//  Africa
//
//  Created by Thomas Mani on 14/09/23.
//

import SwiftUI

struct HeadingView: View {
    
    var headingImage:String
    var headigtext:String
    
    var body: some View {
        HStack {
            Image(systemName: headingImage)
                .foregroundColor(.accentColor)
                .imageScale(.large)
            
            Text(headigtext)
                .font(.title3)
                .fontWeight(.bold)
        }
        .padding(.vertical)
    }
}

struct HeadingView_Previews: PreviewProvider {
    static var previews: some View {
        HeadingView(headingImage: "photo.on.rectangle.angled", headigtext: "Wilderness in picture")
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
