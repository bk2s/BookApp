//
//  BookShelfView.swift
//  BookApp
//
//  Created by  Stepanok Ivan on 23.04.2023.
//

import SwiftUI
import Kingfisher

struct BookShelfView: View {
    
    private var idiom: UIUserInterfaceIdiom { UIDevice.current.userInterfaceIdiom }
    
    private let title: String
    private let titleColor: Color
    private let nameColor: Color
    private let shadowColor: Color
    private let books: [BookModel]
    var bookSelected: (Int) -> Void = {_ in}
    
    init(title: String, books: [BookModel],
         bookSelected: @escaping ((Int) -> Void),
         titleColor: Color = .accentColor,
         shadowColor: Color = .black,
         nameColor: Color = .white.opacity(0.7)) {
        self.title = title
        self.titleColor = titleColor
        self.shadowColor = shadowColor
        self.nameColor = nameColor
        self.books = books
        self.bookSelected = bookSelected
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(title)
                .font(Theme.Fonts.displayMedium)
                .foregroundColor(titleColor)
                .padding(.horizontal, 16)
            ZStack(alignment: .trailing) {
                ScrollView(.horizontal) {
                    HStack(alignment: .top, spacing: 8) {
                        ForEach(Array(books.enumerated()), id: \.offset) { index, book in
                            BookView(book: book, index: index, cellsCount: books.count, nameColor: nameColor)
                                .onTapGesture {
                                    bookSelected(book.id)
                                }
                                .padding(.leading, index == 0 ? 16 : 0)
                        }
                    }
                    Spacer(minLength: 6)
                }
                if idiom == .pad {
                    LinearGradient(colors: [Color.clear, shadowColor.opacity(0.5)],
                                   startPoint: .leading,
                                   endPoint: .trailing)
                        .frame(width: 20)
                }
            }
        }
    }
}

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
            KFImage(URL(string: book.coverURL))
                .onFailureImage(AppAssets.noCover.image)
                .resizable()
                .scaledToFill()
                .frame(width: 120, height: 150)
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

struct BookShelfView_Previews: PreviewProvider {
    static var previews: some View {
        
        let books = [
            BookModel(id: 1, name: "Just Friends",
                      author: "Author",
                      summary: "Summury",
                      genre: "Genre",
                      coverURL: "https://i.pinimg.com/564x/2f/f5/7e/2ff57ee708d4f86b2ce8a7f4758e7dd7.jpg",
                      views: "Views",
                      likes: "Likes",
                      quotes: "Quotes"),
            BookModel(id: 2, name: "The void in your eyes",
                      author: "Author 2",
                      summary: "Summury 2",
                      genre: "Genre 2",
                      coverURL: "https://i.pinimg.com/564x/1d/c3/35/1dc335d3123bf446b0ab0b358554629e.jpg",
                      views: "Views",
                      likes: "Likes",
                      quotes: "Quotes"),
            BookModel(id: 3, name: "Last Year's mistake",
                      author: "Author",
                      summary: "Summury",
                      genre: "Genre",
                      coverURL: "https://i.pinimg.com/564x/f3/e1/68/f3e1685ecc142f0143d6f28b9a77a6b5.jpg",
                      views: "Views",
                      likes: "Likes",
                      quotes: "Quotes"),
            BookModel(id: 4, name: "Inesistible",
                      author: "Author 2",
                      summary: "Summury 2",
                      genre: "Genre 2",
                      coverURL: "https://i.pinimg.com/564x/54/cd/6c/54cd6ce988ca8e62079d6c3c81024efa.jpg",
                      views: "Views",
                      likes: "Likes",
                      quotes: "Quotes"),
            BookModel(id: 5, name: "Never load a cover at the night",
                      author: "Author",
                      summary: "Summury",
                      genre: "Genre",
                      coverURL: "https://i.pinimg.com/564x/d8/61/1e/d8611eadbf839ef4d9c86209cd88649e.jpg.jpg",
                      views: "Views",
                      likes: "Likes",
                      quotes: "Quotes"),
            BookModel(id: 6, name: "Through my window",
                      author: "Author 2",
                      summary: "Summury 2",
                      genre: "Genre 2",
                      coverURL: "https://i.pinimg.com/564x/c1/52/98/c1529833694a4564247b1afdd2bf2e9a.jpg",
                      views: "Views",
                      likes: "Likes",
                      quotes: "Quotes")
        ]
        
        BookShelfView(title: "Demo", books: books, bookSelected: {_ in})
    }
}
