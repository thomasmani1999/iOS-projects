//
//  Movies.swift
//  MovieDatabase
//
//  Created by Thomas Mani on 15/09/23.
//
import Foundation

typealias Movies = [Movie]

extension Movies{

    //Get unique individual years
    func years() -> [String] {
        var years:Set<String> = []
        for movie in self {
            if let year = movie.year {
                years.insert(year)
            }
        }
        return years.sorted()
    }
    
    //Get unique individual genres
    func genres() -> [String] {
        var genres:Set<String> = []
        for movie in self {
            if let genre = movie.genre {
                let values = Set(genre.split(separator: ", ", omittingEmptySubsequences: true).map({ String($0) }))
                genres.formUnion(values)
            }
        }
        return genres.sorted()
    }
    
    //Get unique individual directors
    func directors() -> [String] {
        var directors:Set<String> = []
        for movie in self {
            if let director = movie.director {
                let values = Set(director.split(separator: ", ", omittingEmptySubsequences: true).map({ String($0) }))
                directors.formUnion(values)
            }
        }
        return directors.sorted()
    }
    
    //Get unique individual actors
    func actors() -> [String] {
        var actors:Set<String> = []
        for movie in self {
            if let actorsArray = movie.actors {
                let values = Set(actorsArray.split(separator: ", ", omittingEmptySubsequences: true).map({ String($0) }))
                actors.formUnion(values)
            }
        }
        return actors.sorted()
    }
}
