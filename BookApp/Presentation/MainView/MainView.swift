//
//  ContentView.swift
//  Book
//
//  Created by  Stepanok Ivan on 22.04.2023.
//

import SwiftUI
import Kingfisher

struct MainView: View {

    @ObservedObject var viewModel: MainViewModel
    private var idiom: UIUserInterfaceIdiom { UIDevice.current.userInterfaceIdiom }
    
    var body: some View {
        ZStack {
            if viewModel.isLoading {
                SpinnerView()
                    .frame(width: 40, height: 40)
            } else {
                AppAssets.bgColor.swiftUIColor
                    .edgesIgnoringSafeArea(.vertical)
                ScrollView {
                    
                    // MARK: - Banners Carousel
                    VStack(alignment: .center, spacing: 0) {
                        Spacer(minLength: 20)
                        HStack {
                            Text(AppLocalization.MainView.library)
                                .font(Theme.Fonts.displayMedium)
                                .foregroundColor(.accentColor)
                                .multilineTextAlignment(.leading)
                            Spacer()
                        }.padding(.horizontal, 16)
                            .frame(maxWidth: idiom == .pad ? 600 : .infinity)
                        Spacer(minLength: 28)
                        ImageCarouselView(banners: viewModel.banners,
                                          bannerTapped: { id in
                            viewModel.router.bookDetails(id: id)
                        }).padding(.horizontal, 16)
                        
                        // MARK: - Books sliders
                        VStack {
                            ForEach(Array(viewModel.genres.enumerated()), id: \.offset) {_, genre in
                                Spacer(minLength: 20)
                                BookShelfView(title: genre,
                                              books: viewModel.books.filter({ $0.genre == genre }),
                                              bookSelected: { id in
                                    viewModel.router.bookDetails(id: id)
                                })
                            }
                        }.frame(maxWidth: idiom == .pad ? 600 : .infinity)
                        Spacer(minLength: 70)
                    }
                }
            }
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
        }.navigationBarHidden(true)
           
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = MainViewModel(firebaseManager: FirebaseManagerMock(),
                                      localDataManager: LocalDataManagerMock(),
                                      router: RouterMock())
        MainView(viewModel: viewModel)
            .loadFonts()
    }
}
