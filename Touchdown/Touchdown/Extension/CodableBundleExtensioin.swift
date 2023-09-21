//
//  CodableBundleExtensioin.swift
//  Touchdown
//
//  Created by Thomas Mani on 20/09/23.
//

import Foundation

extension Bundle{
    func decode<T:Codable>(_ file : String) -> T {
        guard let url = Bundle.main.url(forResource: file, withExtension: nil) else {fatalError("1")}
        guard let data = try?Data(contentsOf: url) else {fatalError("2")}
        
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(T.self, from: data) else {fatalError("3")}
        
        return decodedData
    }
}
