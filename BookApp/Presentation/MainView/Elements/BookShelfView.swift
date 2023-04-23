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
                            Button(action: {
                                bookSelected(book.id)
                            }, label: {
                                BookView(book: book,
                                         index: index,
                                         cellsCount: books.count,
                                         nameColor: nameColor)
                            })
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
