//
//  HomeView.swift
//  ApiMvvm
//
//  Created by hendra on 14/10/24.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var homeViewModel: HomeViewModel = HomeViewModel()
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading) {
                HStack {
                    Text("For Username")
                        .font(.title)
                        .padding()
                    Spacer()
                    Image(systemName: "square")
                        .resizable()
                        .frame(width: 28, height: 28)
                        .padding(8)
                    Image(systemName: "magnifyingglass")
                        .resizable()
                        .frame(width: 28, height: 28)
                        .padding(8)
                    Image(systemName: "person")
                        .resizable()
                        .frame(width: 28, height: 28)
                        .padding(8)
                }
                HStack(spacing: 24) {
                    Button {
                        print("Series tapped")
                    } label: {
                        Text("Series")
                            .font(.headline)
                            .foregroundStyle(.white)
                            .padding(8)
                            .background(
                                RoundedRectangle(cornerRadius: 45)
                                    .stroke(Color.white, lineWidth: 2)
                            )
                    }
                    
                    Button {
                        print("Films tapped")
                    } label: {
                        Text("Films")
                            .font(.headline)
                            .foregroundStyle(.white)
                            .padding(8)
                            .background(
                                RoundedRectangle(cornerRadius: 45)
                                    .stroke(Color.white, lineWidth: 2)
                            )
                    }
                    
                    Button {
                        homeViewModel.showCategories.toggle()
                    } label: {
                        HStack {
                            Text("Categories")
                            Image(systemName: "chevron.down")
                        }
                        .font(.headline)
                        .foregroundStyle(.white)
                        .padding(8)
                        .background(
                            RoundedRectangle(cornerRadius: 45)
                                .stroke(Color.white, lineWidth: 2)
                        )
                    }
                    .fullScreenCover(isPresented: $homeViewModel.showCategories) {
                        CategoriesView()
                    }
                }
                .padding(.horizontal, 16)
                ZStack {
                    VStack {
                        Image("filmNow")
                            .resizable()
                            .padding()
                    }
                    
                    VStack {
                        Spacer()
                        Image("filmName")
                        HStack(spacing: 16) {
                            Button {
                                
                            } label: {
                                Image(systemName: "arrowtriangle.right.fill")
                                Text("Play")
                                    .font(.headline)
                            }
                            .frame(maxWidth: .infinity)
                            .foregroundStyle(Color(.black))
                            .padding()
                            .background(Color.white)
                            
                            Button {
                                
                            } label: {
                                Image(systemName: "plus")
                                Text("My List")
                                    .font(.headline)
                            }
                            .frame(maxWidth: .infinity)
                            .foregroundStyle(.white)
                            .padding()
                            .background(Color.black.opacity(0.7))
                            
                        }
                        .frame(maxWidth: .infinity)
                        .padding(32)
                    }
                }
                switch homeViewModel.movieState {
                case .idle:
                    Spacer()
                case .loading:
                    Spacer()
                    ProgressView()
                    Spacer()
                case .error:
                    Spacer()
                    ErrorView()
                    Spacer()
                case .loaded:
                    Text("Tending Now")
                        .font(.headline)
                        .padding()
                    ScrollView(.horizontal, showsIndicators: false) {
                        if homeViewModel.isError {
                            VStack {
                                Spacer()
                                Text("Upss Something Wrong!!!")
                                Image(systemName: "exclamationmark.warninglight.fill")
                                Spacer()
                            }
                        } else {
                            LazyHStack(spacing: 8) {
                                ForEach(homeViewModel.data, id: \.id) { movie in
                                    return CardFilm(movie: movie)
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                }
            }
        }
        .onAppear {
            Task {
                do {
                    try await Task.sleep(nanoseconds: 3 * 1_000_000_000)
                    
                    try await homeViewModel.getMovies()
                    
                } catch {
                    print("Error fetching movies: \(error)")
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
