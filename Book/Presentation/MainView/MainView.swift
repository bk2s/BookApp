//
//  ContentView.swift
//  Book
//
//  Created by  Stepanok Ivan on 22.04.2023.
//

import SwiftUI
import Kingfisher

struct MainView: View {
    let manager: FirebaseManager
    @State var banners: [TopBannerSlide] = []
    
    var body: some View {
        VStack {
           TopBannersView(banners: banners)
        }
        .padding(.horizontal, 16)
        .onAppear {
            Task {
                let banners = await manager.getTopBannerSlides()
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(manager: FirebaseManager())
    }
}

struct TopBannersView: View {
    
    let banners: [TopBannerSlide]
    
    var body: some View {
        VStack {
            ForEach(banners, id: \.bookId) { banner in
                if let url = URL(string: banner.imageUrl) {
                    KFImage(url)
                    Text(banner.bookId)
                }
            }
        }
    }
}
