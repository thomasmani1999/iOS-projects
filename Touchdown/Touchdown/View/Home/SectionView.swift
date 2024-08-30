//
//  SectionView.swift
//  Touchdown
//
//  Created by Thomas Mani on 20/09/23.
//

import SwiftUI

struct SectionView: View {
    
    @State var rotatetClockwise:Bool
    
    var body: some View {
        VStack(spacing:0) {
            Spacer()
            
            Text("Categories".uppercased())
                .font(.footnote)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .rotationEffect(Angle(degrees: rotatetClockwise ? 90 : -90))
            
            Spacer()
        }
        .background(colorGray.cornerRadius(12))
        .frame(width: 85)
    }
}

struct SectionView_Previews: PreviewProvider {
    static var previews: some View {
        SectionView(rotatetClockwise: false)
            .previewLayout(.fixed(width: 120, height: 240))
            .background(colorBackground)
    }
}
