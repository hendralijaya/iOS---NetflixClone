//
//  CardFilm.swift
//  ApiMvvm
//
//  Created by hendra on 22/10/24.
//

import SwiftUI

struct CardFilm: View {
    var movie: Movie
    var body: some View {
        AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w92/\(movie.posterPath ?? "vcZfDONCxoOU7mosZEnkhYujBEG.jpg")")) { image in
            image.resizable()
                .scaledToFill()
        } placeholder: {
            Color.gray.overlay {
                ProgressView()
            }
        }
        .frame(width: 100, height: 150)
        
    }
}

//#Preview {
//    CardFilm(movie: <#Binding<Movie>#>)
//}
