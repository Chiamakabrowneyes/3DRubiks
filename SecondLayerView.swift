

    import SwiftUI
    struct SecondLayerView: View {
        /// View Properties
        
        var body: some View {
            ZStack {
                Color.gray
                    .ignoresSafeArea()
                
                ScrollView(.vertical) {
                    VStack(spacing: 15) {
                        Text("Right Center Algorithm")
                        parallaxCarousel1(cards: secondLayerOne, height: 300)
                        
                        Spacer()
                        Text("Left Center Algorithm")
                        parallaxCarousel1(cards: secondLayerTwo, height: 300)
                    }
                    .padding(15)
                }
                .scrollIndicators(.hidden)
            }
        }
    }
    
    @ViewBuilder
    func parallaxCarousel1(cards: [Card], height: CGFloat) -> some View {
        GeometryReader { geometry in
            let size = geometry.size
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    ForEach(cards) { card in
                        GeometryReader { proxy in
                            let cardSize = proxy.size
                            let minX = proxy.frame(in: .global).minX
                            let xOffset = -minX * 0.2 // Adjust parallax effect here
                            
                            Image(card.image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: cardSize.width, height: cardSize.height)
                                .offset(x: xOffset)
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                                .shadow(color: .black.opacity(0.25), radius: 8, x: 5, y: 10)
                        }
                        .frame(width: size.width - 60, height: height)
                    }
                }
                .padding(.horizontal, 30)
            }
        }
        .frame(height: height)
    }
