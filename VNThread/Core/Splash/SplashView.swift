//
//  splash.swift
//  VNThread
//
//  Created by Apple on 5/31/24.
//

import SwiftUI

struct SplashView: View {
    @State private var isActive = false

        var body: some View {
            if isActive {
                ContentView()
            } else {
                VStack {
                    Image("think")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                }
                .onAppear {
                    // Set delay for splash screen
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        withAnimation {
                            self.isActive = true
                        }
                    }
                }
            }
        }
}

#Preview {
    SplashView()
}
