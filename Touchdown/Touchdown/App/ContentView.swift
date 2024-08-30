//
//  ContentView.swift
//  Touchdown
//
//  Created by Thomas Mani on 20/09/23.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: - Properites
    
    @EnvironmentObject var shop:Shop
    
    // MARK: - Functions
    
    var body: some View {
        VStack {
            if !shop.showingProduct && shop.selectedProduct == nil{
                VStack(spacing: 0) {
                    
                    NavigationBarView()
                        .padding(.horizontal,15)
                        .padding(.bottom)
                        .background(.white )
                        .shadow(color: .black.opacity(0.05), radius: 5, x: 0.0, y: 5)
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(spacing: 0) {
                            FeaturedTabView()
                                .frame(minHeight: 256)
                                .padding(.vertical,20)
                            
                            CategoryGridView()
                            
                            TitleView(title: "Helmets")
                            
                            LazyVGrid(columns: gridLayout,spacing: 15) {
                                ForEach(products) { product in
                                    ProductItemView(product: product)
                                        .onTapGesture {
                                            withAnimation(.easeOut) {
                                                shop.selectedProduct = product
                                                shop.showingProduct = true
                                            }
                                        }
                                }
                            }
                            .padding(15)
                            
                            TitleView(title: "Brands")
                            
                            BrandGridView()
                            
                            FooterView()
                                .padding(.horizontal)
                        }
                    }
                }
                .background(colorBackground.ignoresSafeArea(.all,edges: .all))
            } else {
                ProductDetailView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(Shop())
    }
}
