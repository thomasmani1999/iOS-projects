//
//  CoverImageView.swift
//  Africa
//
//  Created by Thomas Mani on 10/09/23.
//

import SwiftUI

struct CoverImageView: View {
    
    let coverImages : [coverImage] = Bundle.main.decode("covers.json")
    
    var body: some View {
        TabView {
            ForEach(coverImages) { item in
                Image(item.name)
                    .resizable()
                    .scaledToFill()
            }
        }
        .tabViewStyle(.page)
    }
}

struct CoverImageView_Previews: PreviewProvider {
    static var previews: some View {
        CoverImageView()
            .previewLayout(.fixed(width: 400, height: 300))
    }
}
