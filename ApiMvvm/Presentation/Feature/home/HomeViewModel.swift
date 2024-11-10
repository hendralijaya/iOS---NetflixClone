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
    
    // Movies Page
    @Published var page: Int = 1
    
    private let services: MovieServicesProtocol
    
    init(services: MovieServicesProtocol = MovieServicesImpl()) {
        self.services = services
    }
    
    func getMovies() {
        Task {
            try await Task.sleep(nanoseconds: 3 * 1_000_000_000)
            self.movieState = .loading
            do {
                let response = try await services.getMovies(endPoint: .getMovies(page: self.page.description))
                if !response.results.isEmpty {
                    data.append(contentsOf: response.results)
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
    
    func loadMoreMovies() {
        page += 1
        getMovies()
    }
    
    func refreshMovies() {
        page = 1
        data.removeAll()
        getMovies()
    }
}
