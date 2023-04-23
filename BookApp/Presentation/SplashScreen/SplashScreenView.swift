//
//  SplashScreenView.swift
//  BookApp
//
//  Created by  Stepanok Ivan on 23.04.2023.
//

import SwiftUI
import Swinject

struct SplashScreenView: View {
    @State private var isLoading = false
    @State private var scale = false
    let router = Container.shared.resolve(Router.self)!
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            ZStack {
                AppAssets.spashScreen.swiftUIImage
                    .resizable()
                    .scaledToFill()
                    .clipped()
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    Text(AppLocalization.SplashScreen.name)
                        .font(Theme.Fonts.displayLarge)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    Text(AppLocalization.SplashScreen.welcome)
                        .font(Theme.Fonts.displayMedium)
                        .foregroundColor(.white)
                    
                    ProgressBar(isLoading: $isLoading)
                        .frame(width: 200, height: 6)
                        .padding(.bottom, 50)
                }.opacity(scale ? 0 : 1)
            }.scaleEffect(scale ? 5 : 1.01)
                .opacity(scale ? 0.5 : 1)
        }
        .onAppear {
            self.isLoading = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.isLoading = false
                router.showMainScreen()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.6) {
                withAnimation {
                    self.scale = true
                }
            }
        }
    }
}

struct ProgressBar: View {
    @Binding var isLoading: Bool
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 3)
                    .foregroundColor(.white.opacity(0.5))
                RoundedRectangle(cornerRadius: 3)
                    .foregroundColor(.white)
                    .frame(width: self.isLoading ? geometry.size.width : 0, height: 6)
                    .animation(.easeIn(duration: 2))
            }
        }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
