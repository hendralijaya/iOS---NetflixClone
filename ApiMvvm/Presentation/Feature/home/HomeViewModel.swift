//
//  ContentViewModel.swift
//  ApiMvvm
//
//  Created by hendra on 14/10/24.
//

import Foundation
import SwiftUI

enum MovieState {
    case idle
    case loading
    case error
    case loaded
}

@MainActor
class HomeViewModel: ObservableObject {
    @Published var showCategories = false
    @Published var data: [Movie] = []
    @Published var isError: Bool = false
    @Published var movieState: MovieState = .idle
    private let services: MovieServicesProtocol
    
    init(services: MovieServicesProtocol = MovieServicesImpl()) {
        self.services = services
    }
    
    func getMovies(page: String = "1") async throws {
        self.movieState = .loading
        do {
            let response = try await services.getMovies(endPoint: .getMovies(page: page))
            if !response.results.isEmpty {
                data = response.results
                self.movieState = .loaded
            }
            self.isError = false
            self.movieState = .loaded
        } catch {
            self.isError = true
            self.movieState = .error
        }
    }
    
}
