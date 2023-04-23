//
//  SkeletonView.swift
//  BookApp
//
//  Created by  Stepanok Ivan on 23.04.2023.
//

import SwiftUI

struct SkeletonView: View {
    @State private var animation = false
    var body: some View {
        GeometryReader { reader in
            ZStack {
                Rectangle()
                    .foregroundColor(.gray.opacity(0.2))
                Rectangle()
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [.clear,
                                                        .clear,
                                                        .clear,
                                                        .white.opacity(0.5),
                                                        .clear,
                                                        .clear,
                                                        .clear]),
                            startPoint: .bottomLeading,
                            endPoint: .topTrailing
                        )
                    )
                    .opacity(0.5)
                    .scaleEffect(4)
                    .offset(y: animation ? -reader.size.height * 2 : reader.size.height * 2)
                    .scaleEffect(animation ? 2 : 1.5, anchor: .center)
                    .animation(
                        Animation.easeInOut(duration: 2.5)
                            .repeatForever(autoreverses: false)
                    )
                    .onAppear {
                        self.animation.toggle()
                    }
            }
        }
    }
}

struct SkeletonView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black
            SkeletonView()
        }
    }
}
