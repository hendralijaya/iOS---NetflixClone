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
                Header()
                Categories()
                    .environmentObject(homeViewModel)
                Hero()
                TrendingSection()
                    .environmentObject(homeViewModel)
            }
        }
        .refreshable {
            homeViewModel.refreshMovies()
        }
        .onAppear {
            homeViewModel.getMovies()
        }
    }
}

#Preview {
    HomeView()
}

struct Header: View {
    var body: some View {
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
    }
}

struct Categories: View {
    @EnvironmentObject var homeViewModel: HomeViewModel
    
    var body: some View {
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
    }
}

struct Hero: View {
    var body: some View {
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
    }
}

struct TrendingSection: View {
    @EnvironmentObject var homeViewModel: HomeViewModel
    
    var body: some View {
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
                        ForEach(homeViewModel.data, id: \.uuid) { movie in
                            CardFilm(movie: movie)
                                .geometryGroup()
                                .onAppear {
                                    if movie.uuid == homeViewModel.data.last?.uuid {
                                        homeViewModel.loadMoreMovies()
                                    }
                                }
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
    }
}
