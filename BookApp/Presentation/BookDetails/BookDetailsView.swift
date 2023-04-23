//
//  BookDetailsView.swift
//  BookApp
//
//  Created by  Stepanok Ivan on 23.04.2023.
//

import SwiftUI

struct BookDetailsView: View {
    
    @State private var stateModel: UIStateModel = UIStateModel()

    @ObservedObject var viewModel: BookDetailsViewModel
    @State private var selectedBook: Int = 0
    private var idiom: UIUserInterfaceIdiom { UIDevice.current.userInterfaceIdiom }
    
    init(viewModel: BookDetailsViewModel,
         selectedBook: Int) {
        self.viewModel = viewModel
        self.selectedBook = selectedBook
        stateModel.activeCard = selectedBook
    }
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            if viewModel.isLoading {
                SpinnerView()
                    .frame(width: 40, height: 40)
            } else {
                Color.white
                ScrollViewReader { scroll in
                    ScrollView {
                        VStack(alignment: .center, spacing: 0) {
                            
                            // MARK: - SnapCarousel
                            ZStack(alignment: .topLeading) {
                                AppAssets.bgDetails.swiftUIImage
                                    .resizable()
                                    .ignoresSafeArea()
                                    .clipped()
                                SnapCarouselView(items: viewModel.books)
                                    .environmentObject(stateModel)
                                    .offset(y: idiom == .pad ? 0 : 30)
                                    .id(0)
                                Button(action: {
                                    viewModel.router.back(animated: true)
                                }, label: {
                                    AppAssets.back.swiftUIImage
                                        .frame(width: 23, height: 36)
                                }).padding(24)
                                    .offset(y: 20)
                                
                            }.frame(height: idiom == .pad ? 550 : 380)
                            
                            // MARK: - BookDetails
                            ZStack(alignment: .top) {
                                Color.white
                                    .cornerRadius(20, corners: [.topLeft, .topRight])
                                VStack(alignment: .center) {
                                    let book = viewModel.books[selectedBook]
                                    
                                    // MARK: - Interactions
                                    HStack(alignment: .top) {
                                        SummaryView(type: .readers, interactions: book.views)
                                        Spacer()
                                        SummaryView(type: .likes, interactions: book.likes)
                                        Spacer()
                                        SummaryView(type: .quotes, interactions: book.quotes)
                                        Spacer()
                                        SummaryView(type: .genre, interactions: book.genre)
                                    }.padding(16)
                                    
                                    // MARK: - Summary
                                    Divider()
                                    Text(book.summary)
                                        .foregroundColor(.black)
                                        .multilineTextAlignment(.leading)
                                        .font(Theme.Fonts.bodyMedium)
                                        .padding(16)
                                    // MARK: - Also like
                                    Divider()
                                    BookShelfView(title: AppLocalization.Details.alsoLike,
                                                  books: viewModel.likedBooks,
                                                  bookSelected: { book in
                                        stateModel.activeCard = book
                                    },
                                                  titleColor: .black,
                                                  shadowColor: .white,
                                                  nameColor: .black)
                                    Spacer(minLength: 70)
                                }
                                .frame(maxWidth: idiom == .pad ? 540 : .infinity)
                                .onRightSwipeGesture {
                                    viewModel.router.back(animated: true)
                                }
                            }.frame(minHeight: 0,
                                    maxHeight: .infinity,
                                    alignment: .top)
                            .offset(y: -22)
                            
                        }
                    }.ignoresSafeArea()
                    
                        .onReceive(stateModel.$activeCard, perform: { card in
                            withAnimation {
                                self.selectedBook = card
                                scroll.scrollTo(0)
                            }
                        })
                }
                .navigationBarHidden(true)
                if viewModel.showError {
                    VStack {
                        Spacer()
                        SnackBarView(message: viewModel.errorMessage)
                    }.transition(.move(edge: .bottom))
                        .onAppear {
                            doAfter(5) {
                                viewModel.errorMessage = nil
                            }
                        }
                }
            }
        }.edgesIgnoringSafeArea(.bottom)
    }
}

struct BookDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = BookDetailsViewModel(firebaseManager: FirebaseManagerMock(),
                                             localDataManager: LocalDataManagerMock(),
                                             router: RouterMock())
        BookDetailsView(viewModel: viewModel, selectedBook: 0)
    }
}
