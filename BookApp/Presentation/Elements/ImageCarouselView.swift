//
//  ImageCarouselView.swift
//  BookApp
//
//  Created by  Stepanok Ivan on 23.04.2023.
//

import SwiftUI
import Kingfisher

struct ImageCarouselView: View {
    private var banners: [TopBanner]
    @State var slideGesture: CGSize = CGSize.zero
    @State private var currentIndex: Int = 0
    @State private var isAutoScrollEnabled = true
    private let autoScrollTimer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    private let scrollTimeoutTimer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
    
    var bannerTapped: (Int) -> Void = {_ in}
    
    init(banners: [TopBanner], bannerTapped: @escaping ((Int) -> Void)) {
        self.banners = banners
        self.bannerTapped = bannerTapped
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottom) {
                HStack(spacing: 0) {
                    ForEach(Array(banners.enumerated()), id: \.offset) { _, banner in
                        if let url = URL(string: banner.coverUrl) {
                            ZStack {
                                SkeletonView()
                                KFImage(url)
//                                    .onFailureImage(AppAssets.noCover.image)
                                    .resizable()
                                    .onTapGesture {
                                        self.bannerTapped(banner.bookID)
                                    }
                            }
                            .scaledToFill()
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            .clipped()
                        }
                    }
                }
                
                .frame(width: geometry.size.width, height: geometry.size.height, alignment: .leading)
                .offset(x: CGFloat(self.currentIndex) * -geometry.size.width, y: 0)
                .animation(.spring())
                .onReceive(self.autoScrollTimer) { _ in
                    if self.isAutoScrollEnabled {
                        self.currentIndex = (self.currentIndex + 1)
                        % (self.banners.count == 0 ? 1 : self.banners.count)
                    }
                }
                HStack(spacing: 10) {
                    ForEach(0..<self.banners.count, id: \.self) { index in
                        Circle()
                            .frame(width: index == self.currentIndex ? 7 : 8,
                                   height: index == self.currentIndex ? 7 : 8)
                            .foregroundColor(index == self.currentIndex ? Color.accentColor : .white.opacity(0.5))
                            .padding(.bottom, 8)
                            .animation(.spring())
                    }
                }
            }
            
            .gesture(DragGesture().onChanged { value in
                self.slideGesture = value.translation
                self.isAutoScrollEnabled = false
            }
                .onEnded { _ in
                    if self.slideGesture.width < -50 {
                        if self.currentIndex < self.banners.count - 1 {
                            withAnimation {
                                self.currentIndex += 1
                            }
                        } else if self.currentIndex == self.banners.count - 1 {
                            self.currentIndex = 0
                        }
                    }
                    if self.slideGesture.width > 50 {
                        if self.currentIndex > 0 {
                            withAnimation {
                                self.currentIndex -= 1
                            }
                        } else if self.currentIndex == 0 {
                            self.currentIndex = self.banners.count - 1
                        }
                    }
                    self.slideGesture = .zero
                    self.isAutoScrollEnabled = false
                })
            .onReceive(self.scrollTimeoutTimer) { _ in
                self.isAutoScrollEnabled = true
            }
        }
        .cornerRadius(16)
        .aspectRatio( 2/1, contentMode: .fit)
    }
}

struct ImageCarouselView_Previews: PreviewProvider {
    static var previews: some View {
        let banners: [TopBanner] = [
            TopBanner(id: 1, bookID: 1, coverUrl: "https://i.pinimg.com/564x/9a/d6/ad/9ad6ade006446f1fa36b812c91c32184.jpg"),
            TopBanner(id: 2, bookID: 2, coverUrl: "https://i.pinimg.com/564x/d0/5c/11/d05c11aa655091c6c59efb5773c3d1cb.jpg"),
            TopBanner(id: 3, bookID: 3, coverUrl: "https://i.pinimg.com/564x/dd/8f/bf/dd8fbfed20852341fa1e4136baa31a70.jpg"),
            TopBanner(id: 3, bookID: 3, coverUrl: "https://i.pinimg.com/564x/42/fb/6c/42fb6cc4a9eeb836bd6dde4eccf694fe.jpg"),
            TopBanner(id: 3, bookID: 3, coverUrl: "https://i.pinimg.com/564x/12/0d/fd/120dfde0de5b8dcaf4d461168c8ba72d.jpg")
        ]
        
        ZStack {
            ImageCarouselView(banners: banners, bannerTapped: {_ in})
        }
    }
}
