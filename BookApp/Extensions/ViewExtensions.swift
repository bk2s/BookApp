//
//  ViewExtensions.swift
//  BookApp
//
//  Created by  Stepanok Ivan on 23.04.2023.
//

import SwiftUI

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
    
    func onRightSwipeGesture(perform action: @escaping () -> Void) -> some View {
        self.gesture(
            DragGesture(minimumDistance: 20, coordinateSpace: .local)
                .onEnded { value in
                    if value.translation.width > 0 && abs(value.translation.height) < 50 {
                        action()
                    }
                }
        )
    }
    
    func roundedBackground(_ cornerRadius: CGFloat = 11, bgColor: Color = AppAssets.accentColor.swiftUIColor) -> some View {
        if #available(iOS 15.0, *) {
            return self.background {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .foregroundColor(bgColor)
            }
        } else {
            return ZStack(alignment: .center) {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .foregroundColor(bgColor)
                self
            }
        }
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
