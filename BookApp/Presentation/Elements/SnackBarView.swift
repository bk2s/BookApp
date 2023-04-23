//
//  SnackBarView.swift
//  BookApp
//
//  Created by  Stepanok Ivan on 23.04.2023.
//

import SwiftUI

public struct SnackBarView: View {
    
    var message: String
    
    private var safeArea: CGFloat {
        UIApplication.shared.windows.first { $0.isKeyWindow }?.safeAreaInsets.bottom ?? 0
    }
    
    private let minHeight: CGFloat = 50
    
    public init(message: String?) {
        self.message = message ?? ""
    }
    
    public var body: some View {
        HStack {
            Text(message)
                .font(Theme.Fonts.bodyMedium)
                .padding(16)
                .foregroundColor(.white)
            Spacer()
            
        }
            .roundedBackground()
            .padding()
    }
}

struct SnackBarView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SnackBarView(message: "Text message")
                .previewLayout(PreviewLayout.sizeThatFits)
                .previewDisplayName("Just text")
            
            SnackBarView(message: "Text message")
             .previewLayout(PreviewLayout.sizeThatFits)
            .previewDisplayName("With action button")
        }
    }
}

public func doAfter(_ delay: TimeInterval? = nil, _ closure: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + (delay ?? 0), execute: closure)
}
