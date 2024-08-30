//
//  VideoListView.swift
//  Africa
//
//  Created by Thomas Mani on 10/09/23.
//

import SwiftUI

struct VideoListView: View {
    
    @State var videos:[Video] = Bundle.main.decode("videos.json")
    
    var body: some View {
        NavigationView {
            List {
                ForEach(videos) { video in
                    NavigationLink(destination: {
                        VideoPlayerView(videoSelected: video.id, videoTitle: video.name)
                    }, label: {
                        VideoListItemView(video: video)
                            .padding(.vertical,8)
                    })
                }
            }
            .navigationTitle("Videos")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        videos.shuffle()
                    } label: {
                        Image(systemName: "arrow.2.squarepath")
                    }

                }
            }
            .listStyle(.insetGrouped)
        }
    }
}

struct VideoListView_Previews: PreviewProvider {
    static var previews: some View {
        VideoListView()
    }
}
