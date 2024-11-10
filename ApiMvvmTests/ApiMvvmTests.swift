//
//  ApiMvvmTests.swift
//  ApiMvvmTests
//
//  Created by hendra on 14/10/24.
//

import Testing
@testable import ApiMvvm

struct ApiMvvmTests {
    var movieService: MovieServicesImpl!
    var mockNetworker: Networker!
    
    mutating func setUp() {
        mockNetworker = Networker()
        movieService = MovieServicesImpl(networker: mockNetworker)
    }
    @Test mutating func example() async throws {
        setUp()
        let data = try await movieService.getMovies(endPoint: .getMovies(page: "1"))
        assert(data.results.count > 0)
    }
    
}
