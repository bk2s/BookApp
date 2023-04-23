//
//  SnapCarouselView.swift
//  BookApp
//
//  Created by  Stepanok Ivan on 23.04.2023.
//

import SwiftUI
import Kingfisher

struct SnapCarouselView: View {
    @EnvironmentObject var UIState: UIStateModel
    
    let items: [BookModel]
    private var idiom: UIUserInterfaceIdiom { UIDevice.current.userInterfaceIdiom }

    init(items: [BookModel]) {
        self.items = items
    }
    
    var body: some View {
        let spacing: CGFloat = idiom == .pad ? 32 : 16
        let widthOfHiddenCards: CGFloat = idiom == .pad ? 64 : 32
        let cardHeight: CGFloat = idiom == .pad ? 500 : 250
                
        return Canvas {
            Carousel(
                numberOfItems: CGFloat(items.count),
                spacing: spacing,
                widthOfHiddenCards: widthOfHiddenCards
            ) {
                ForEach(items, id: \.self.id) { item in
                    Item(
                        _id: Int(item.id),
                        spacing: spacing,
                        widthOfHiddenCards: widthOfHiddenCards,
                        cardHeight: cardHeight
                    ) {
                        VStack {
                            KFImage(URL(string: item.coverURL))
                                .onFailureImage(AppAssets.noCover.image)
                                .resizable()
                                .aspectRatio(4/5, contentMode: .fit)
                                .clipped()
                                .cornerRadius(16)
                            Text(item.name)
                                .font(Theme.Fonts.displayMedium)
                            Text(item.author)
                                .font(Theme.Fonts.bodyMedium)
                        }.multilineTextAlignment(.center)
                            .frame(width: idiom == .pad ? 400 : 300)

                    }
                    .foregroundColor(Color.white)
                    .cornerRadius(8)
                    .transition(AnyTransition.slide)
                    .animation(.spring())
                }
            }.padding(.vertical, 24)
        }
    }
}

struct Card: Decodable, Hashable, Identifiable {
    var id: Int
    var name: String = ""
}

public class UIStateModel: ObservableObject {
    @Published var activeCard: Int = 0
    @Published var screenDrag: Float = 0.0
}

struct Carousel<Items: View>: View {
    let items: Items
    let numberOfItems: CGFloat
    let spacing: CGFloat
    let widthOfHiddenCards: CGFloat
    let totalSpacing: CGFloat
    let cardWidth: CGFloat
    
    @GestureState var isDetectingLongPress = false
    
    @EnvironmentObject var UIState: UIStateModel
        
    @inlinable public init(
        numberOfItems: CGFloat,
        spacing: CGFloat,
        widthOfHiddenCards: CGFloat,
        @ViewBuilder _ items: () -> Items) {
        
        self.items = items()
        self.numberOfItems = numberOfItems
        self.spacing = spacing
        self.widthOfHiddenCards = widthOfHiddenCards
        self.totalSpacing = (numberOfItems - 1) * spacing
        self.cardWidth = UIScreen.main.bounds.width - (widthOfHiddenCards*4) - (spacing*4)
        
    }
    
    var body: some View {
        let totalCanvasWidth: CGFloat = (cardWidth * numberOfItems) + totalSpacing
        let xOffsetToShift = (totalCanvasWidth - UIScreen.main.bounds.width) / 2
        let leftPadding = widthOfHiddenCards + spacing
        let totalMovement = cardWidth + spacing
                
        let activeOffset = xOffsetToShift + (leftPadding) - (totalMovement * CGFloat(UIState.activeCard))
        let nextOffset = xOffsetToShift + (leftPadding) - (totalMovement * CGFloat(UIState.activeCard) + 1)

        var calcOffset = Float(activeOffset)
        
        if (calcOffset != Float(nextOffset)) {
            calcOffset = Float(activeOffset) + UIState.screenDrag
        }
        
        return HStack(alignment: .center, spacing: spacing) {
            items
        }
        .offset(x: CGFloat(calcOffset), y: 0)
        .offset(x: UIScreen.main.bounds.width / 9)
        .gesture(DragGesture().updating($isDetectingLongPress) { currentState, gestureState, transaction in
            DispatchQueue.main.async {
                self.UIState.screenDrag = Float(currentState.translation.width)
            }
            
        }.onEnded { value in
            self.UIState.screenDrag = 0
            
            if (value.translation.width < -50) &&  self.UIState.activeCard < Int(numberOfItems) - 1 {
                self.UIState.activeCard += 1
                let impactMed = UIImpactFeedbackGenerator(style: .medium)
                impactMed.impactOccurred()
            }
            
            if (value.translation.width > 50) && self.UIState.activeCard > 0 {
                self.UIState.activeCard -= 1
                let impactMed = UIImpactFeedbackGenerator(style: .medium)
                impactMed.impactOccurred()
            }
        })
    }
}

struct Canvas<Content: View>: View {
    let content: Content
    @EnvironmentObject var UIState: UIStateModel
    
    @inlinable init(@ViewBuilder _ content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        content
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
            .background(Color.clear.edgesIgnoringSafeArea(.all))
    }
}

struct Item<Content: View>: View {
    @EnvironmentObject var UIState: UIStateModel
    let cardWidth: CGFloat
    let cardHeight: CGFloat

    var _id: Int
    var content: Content
    private var idiom: UIUserInterfaceIdiom { UIDevice.current.userInterfaceIdiom }

    @inlinable public init(
        _id: Int,
        spacing: CGFloat,
        widthOfHiddenCards: CGFloat,
        cardHeight: CGFloat,
        @ViewBuilder _ content: () -> Content
    ) {
        self.content = content()
        self.cardWidth = UIScreen.main.bounds.width - (widthOfHiddenCards*4) - (spacing*4)
        self.cardHeight = cardHeight
        self._id = _id
    }

    var body: some View {
        content
            .frame(width: cardWidth,
                   height: _id == UIState.activeCard ? cardHeight : cardHeight - (idiom == .pad ? 120 : 60),
                   alignment: .center)
    }
}
