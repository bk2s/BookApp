//
//  BookView.swift
//  BookApp
//
//  Created by  Stepanok Ivan on 23.04.2023.
//

import SwiftUI
import Kingfisher

struct BookView: View {
    
    @State private var showView = false
    
    private var book: BookModel
    private var index: Double
    private var cellsCount: Int
    private let nameColor: Color
    
    init(book: BookModel, index: Int, cellsCount: Int, nameColor: Color) {
        self.book = book
        self.index = Double(index)
        self.cellsCount = cellsCount
        self.nameColor = nameColor
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack(alignment: .center) {
                SkeletonView()
                KFImage(URL(string: book.coverURL))
                //                        .onFailureImage(AppAssets.noCover.image)
                    .resizable()
                    .scaledToFill()
            }.frame(width: 120, height: 150)
                .clipped()
                .cornerRadius(16)
            
            Text(book.name)
                .foregroundColor(nameColor)
                .font(Theme.Fonts.bodyMedium)
        }.frame(width: 120)
            .opacity(showView ? 1 : 0)
            .offset(y: showView ? 0 : 20)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now()) {
                    withAnimation(.easeInOut(duration: (index <= 5 ? 0.3 : 0.1))
                        .delay((index <= 5 ? index : 0) * 0.05)) {
                            showView = true
                        }
                }
            }
    }
}
