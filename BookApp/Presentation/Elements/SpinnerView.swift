//
//  SpinnerView.swift
//  BookApp
//
//  Created by  Stepanok Ivan on 23.04.2023.
//

import SwiftUI

struct SpinnerView: View {
    @State private var isAnimating = false
    
    var body: some View {
        GeometryReader { geometry in
            ForEach(0..<5) { index in
                Circle()
                    .foregroundColor(AppAssets.accentColor.swiftUIColor)
                    .frame(width: geometry.size.width / 5, height: geometry.size.height / 5)
                    .scaleEffect(!isAnimating ? 1 - CGFloat(index) / 5 : 0.2 + CGFloat(index) / 5)
                    .offset(y: geometry.size.width / 10 - geometry.size.height / 2)
                    .rotationEffect(!isAnimating ? .degrees(0) : .degrees(360))
                    .animation(Animation
                        .timingCurve(0.5, Double(index) / 5 + 0.5, 0.5, 1, duration: 1.5)
                        .repeatForever(autoreverses: false))
            }
        }
        .aspectRatio(1, contentMode: .fit)
        .onAppear {
            self.isAnimating = true
        }
    }
}

struct SpinnerView_Previews: PreviewProvider {
    static var previews: some View {
        SpinnerView()
            .frame(width: 40, height: 40)
    }
}
