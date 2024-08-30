//
//  GalleryView.swift
//  Africa
//
//  Created by Thomas Mani on 10/09/23.
//

import SwiftUI

struct GalleryView: View {
    
    
    let animals:[Animal] = Bundle.main.decode("animals.json")
    
    @State private var columnNumber:Double = 3.0
    @State private var selectedanimal = "lion"
    @State private var gridLayout:[GridItem] = [GridItem(.flexible())]
    
    func gridSwitch(){
        gridLayout = Array(repeating: .init(.flexible()), count: Int(columnNumber))
    }
    
    var body: some View {
        ScrollView(.vertical,showsIndicators: false) {
            //Grid
            VStack(alignment:.center,spacing: 30) {
                
                Image(selectedanimal)
                    .imageModifiers()
                
                Slider(value: $columnNumber, in: 2...4, step: 1)
                    .padding(.horizontal)
                    .onChange(of:  columnNumber) { newValue in
                        gridSwitch()
                    }
                
                LazyVGrid(columns: gridLayout,alignment: .center,spacing: 10) {
                    ForEach(animals) { item in
                        Image(item.image)
                            .imageModifiers()
                            .onTapGesture {
                                selectedanimal = item.image
                            }
                    }
                }
                .animation(.easeIn)
                .onAppear {
                    gridSwitch()
                }
            }
            .padding(.horizontal,10)
            .padding(.vertical,50)
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity)
        .background(MotionAnimationView())
    }
}

struct GalleryView_Previews: PreviewProvider {
    static var previews: some View {
        GalleryView()
    }
}

extension Image{
    func imageModifiers() -> some View{
        self.resizable()
        .scaledToFit()
        .clipShape(Circle())
        .overlay {
            Circle()
                .stroke(Color.white,lineWidth: 1)
        }
    }
}
