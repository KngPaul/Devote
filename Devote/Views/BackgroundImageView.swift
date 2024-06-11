//
//  BackgroundImageView.swift
//  Devote
//
//  Created by Paul Onawola on 11/06/2024.
//

import SwiftUI

struct BackgroundImageView: View {
    var body: some View {
        ZStack {
            backgroundGradient
                .ignoresSafeArea(.all)
            
            Image("rocket")
                .antialiased(true)
                .resizable()
                .scaledToFill()
            .ignoresSafeArea(.all)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    BackgroundImageView()
}
