//
//  MovieResponse.swift
//  ApiMvvm
//
//  Created by hendra on 22/10/24.
//

import Foundation

struct MovieResponse: Codable, Equatable {
    static func == (lhs: MovieResponse, rhs: MovieResponse) -> Bool {
        lhs.results == rhs.results
    }
    
    let dates: Dates
    let page: Int
    let results: [Movie]
    
}
