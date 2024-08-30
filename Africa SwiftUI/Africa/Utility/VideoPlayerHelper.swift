//
//  VideoPlayerHelper.swift
//  Africa
//
//  Created by Thomas Mani on 15/09/23.
//

import Foundation
import AVKit

var videoPlayer:AVPlayer?

func playVideo(filename:String,fileFormat:String) -> AVPlayer{
    if let url = Bundle.main.url(forResource: filename, withExtension: fileFormat) {
        videoPlayer = AVPlayer(url: url)
        videoPlayer?.play()
    }
    return videoPlayer!
}
