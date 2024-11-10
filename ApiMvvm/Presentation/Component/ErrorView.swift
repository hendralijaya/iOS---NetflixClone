//
//  ErrorView.swift
//  ApiMvvm
//
//  Created by hendra on 22/10/24.
//

import SwiftUI

struct ErrorView: View {
    var body: some View {
        VStack(alignment: .center) {
            Image(systemName: "exclamationmark.warninglight.fill")
                .resizable()
                .frame(width: 100, height: 100)
            Text("UPPSS SOMETHING WRONG PLEASE CHECK YOUR CODE!!!")
        }
    }
}
