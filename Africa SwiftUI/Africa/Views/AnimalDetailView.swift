//
//  DetailView.swift
//  Africa
//
//  Created by Thomas Mani on 14/09/23.
//

import SwiftUI

struct AnimalDetailView: View {
    
    var animal:Animal
    
    var body: some View {
        ScrollView(.vertical,showsIndicators: false) {
            VStack(alignment: .center, spacing: 20) {
                
                //Hero image
                
                Image(animal.image)
                    .resizable()
                    .scaledToFit()
                
                //Title
                
                Text(animal.name.uppercased())
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .multilineTextAlignment(.center)
                    .padding(.vertical,8)
                    .foregroundColor(.primary)
                    .background(
                        Color.accentColor
                            .frame(height: 6)
                            .offset(y:24)
                    )
                
                //Headline
                
                Text(animal.headline)
                    .font(.headline)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.accentColor)
                    .padding(.horizontal )
                
                //Gallery
                
                Group {
                    HeadingView(headingImage: "photo.on.rectangle.angled", headigtext: "Wilderness in pictures")
                    
                    InsetGalleryView(animal: animal)
                }.padding(.horizontal)
                
                //Facts
                
                Group{
                    HeadingView(headingImage: "questionmark.circle", headigtext: "Did you know?")
                    
                    InsetFactView(animal: animal)
                }.padding(.horizontal)
                
                //Description
                
                Group {
                    HeadingView(headingImage: "info.circle", headigtext: "All about \(animal.name)")
                    
                    Text(animal.description)
                        .multilineTextAlignment(.leading)
                        .layoutPriority(1)
                }
                .padding(.horizontal)
                
                //Map
                
                Group{
                    HeadingView(headingImage: "map", headigtext: "National Parks")
                    
                    InsetMapView()
                }.padding(.horizontal)
                
                //Link
                
                Group {
                    HeadingView(headingImage: "books.vertical", headigtext: "learn more")
                    
                    ExternalWeblinkView(animal: animal)
                }
                
            }
            .navigationTitle("Learn about \(animal.name)")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    
    static let animals : [Animal] = Bundle.main.decode("animals.json")
    
    static var previews: some View {
        NavigationView {
            AnimalDetailView(animal: animals[0])
        }
    }
}
