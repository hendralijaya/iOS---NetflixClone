//
//  MovieServices.swift
//  ApiMvvm
//
//  Created by hendra on 22/10/24.
//

import Foundation

protocol MovieServicesProtocol: AnyObject {
    var networker: NetworkerProtocol { get }
    func getMovies(endPoint: NetworkFactory) async throws -> MovieResponse
}

final class MovieServicesImpl: MovieServicesProtocol {
    var networker: NetworkerProtocol
    
    init(networker: NetworkerProtocol = Networker()) {
        self.networker = networker
    }
    
    func getMovies(endPoint: NetworkFactory) async throws -> MovieResponse {
        return try await networker.taskAsync(type: MovieResponse.self, endPoint: endPoint, isMultipart: false)
    }
}
