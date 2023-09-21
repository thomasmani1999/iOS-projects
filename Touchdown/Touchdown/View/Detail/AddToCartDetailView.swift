//
//  AddToCartDetailView.swift
//  Touchdown
//
//  Created by Thomas Mani on 21/09/23.
//

import SwiftUI

struct AddToCartDetailView: View {
    
    @EnvironmentObject var shop:Shop
    
    var body: some View {
        Button {
            
        } label: {
            Spacer()
            
            Text("Add to cart".uppercased())
                .font(.system(.title2,design: .rounded))
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            Spacer()
        }
        .padding(15)
        .background(
            shop.selectedProduct?.bgColor ?? sampleProduct.bgColor
        )
    
        .clipShape(Capsule())

    }
}

struct AddToCartDetailView_Previews: PreviewProvider {
    static var previews: some View {
        AddToCartDetailView()
            .environmentObject(Shop())
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
