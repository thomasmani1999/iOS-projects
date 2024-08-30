//
//  VideoModel.swift
//  Africa
//
//  Created by Thomas Mani on 15/09/23.
//

import Foundation

struct Video:Codable,Identifiable{
    var id:String
    var name:String
    var headline:String
    
    var thumbnail:String {
        "video-\(id)"
    }
}
