//
//  CodableBundleExtension.swift
//  Africa
//
//  Created by Thomas Mani on 10/09/23.
//

import Foundation

extension Bundle {
    func decode<T:Codable>(_ file: String) -> T{
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate json file")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load json file")
        }
        
        let decoder = JSONDecoder()
        
        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode json file")
        }
        
        return loaded
    }
}
