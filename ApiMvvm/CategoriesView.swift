//
//  CategoriesView.swift
//  ApiMvvm
//
//  Created by hendra on 14/10/24.
//

import SwiftUI

struct CategoriesView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            List {
                Text("Available for Download")
                Text("2024 Netflix Oscars")
                Text("Action & Adventure")
                Text("Anime")
                Text("Biographical")
                Text("Blockbusters")
                Text("Bollywood")
                Text("Kids & Family")
                Text("Comedies")
                Text("Documentaries")
                Text("Dramas")
                Text("Fantasy")
            }
            .foregroundStyle(.gray)
            .listStyle(PlainListStyle())
            
            Spacer()
            
            // Close button (like the "X" in your screenshot)
            Button(action: {
                dismiss()
            }) {
                Image(systemName: "xmark")
                    .font(.system(size: 30))
                    .foregroundStyle(.background)
                    .padding()
                    .background(Circle().fill(Color.white.opacity(0.7)))
            }
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.opacity(0.9))
    }
}

#Preview {
    CategoriesView()
}
