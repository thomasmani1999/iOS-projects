//
//  ProductDetailView.swift
//  Touchdown
//
//  Created by Thomas Mani on 20/09/23.
//

import SwiftUI

struct ProductDetailView: View {
    
    @EnvironmentObject var shop : Shop
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            //Nav bar
            NavigationBarDetailView()
                .padding()
            //header
            HeaderDetailView()
                .padding(.horizontal)
            
            //Top part
            TopPartDetailView()
                .padding(.horizontal)
                .zIndex(1)
            //Bottom part
            VStack(alignment: .center, spacing: 0) {
                //Rating + sizes
                
                RatingsSizeDetailView()
                    .padding(.top,-20)
                    .padding(.bottom,10)
                
                //Description
                ScrollView(.vertical, showsIndicators: false) {
                    Text(shop.selectedProduct?.description ?? "")
                        .font(.system(.body,design: .rounded))
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.leading)
                }
                //Quantiy+fav
                
                QuantityFavouriteDetailView()
                    .padding(.vertical,10)
                
                //Add to cart
                
                AddToCartDetailView()
                    .padding(.bottom,20)
            }
            .padding(.horizontal)
            .ignoresSafeArea(.all,edges: .all)
            .background(
                Color.white
                    .clipShape(CustomShape())
                    .padding(.top,-105)
                    .ignoresSafeArea(.all,edges: .all )
                
            )
            
            
        }
        .zIndex(0)
        .background((shop.selectedProduct?.bgColor ?? .gray).ignoresSafeArea(.all,edges: .all))
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailView()
            .environmentObject(Shop())
            .previewLayout(.fixed(width: 375, height: 812))
    }
}
