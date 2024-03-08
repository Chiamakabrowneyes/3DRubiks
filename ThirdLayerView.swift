import SwiftUI
struct ThirdLayerView: View {
    /// View Properties
    
    var body: some View {
        ZStack {
            Color.gray
                .ignoresSafeArea()
            
            ScrollView(.vertical) {
                VStack(spacing: 15) {
                    Spacer()
                    Text("L-Shape Algorithm ")
                    parallaxCarousel(cards: LShape3Layer, height: 300)
                    
                    Spacer()
                    Text("Flat Shape Algorithm")
                    parallaxCarousel(cards: FlatShape3Layer, height: 300)
                    
                    Spacer()
                    Text("Cross Shape ALgorithm")
                    parallaxCarousel(cards: CrossShape1, height: 300)
                    
                    Spacer()
                    Text("Cross Shape with Polar Opposites Algorithm")
                    parallaxCarousel(cards: CrossShape2, height: 300)
                    
                    Spacer()
                    Text("Knob Shape with Same Sides Algorithm")
                    parallaxCarousel(cards: KnobShape1, height: 300)
                    
                    Spacer()
                    Text("Knob Shape with Opposite Sides Algorithm")
                    parallaxCarousel(cards: KnobShape2, height: 300)
                    
                    Spacer()
                    Text("Adjacent Cross Shape Algorithm")
                    parallaxCarousel(cards: AdjacentCross1, height: 300)
                    
                    Spacer()
                    Text("Adjacent Cross Shape ALgorithm")
                    parallaxCarousel(cards: AdjacentCross2, height: 300)
                    
                    Spacer()
                    Text("Snake Shape Algorithm")
                    parallaxCarousel(cards: SnakeShape1, height: 300)
                    
                    Spacer()
                    Text("Last Move ")
                    parallaxCarousel(cards: LastMove, height: 300)
                    
                    Spacer()
                    Text("Last Move 2")
                    parallaxCarousel(cards: LastMove2, height: 300)
                }
                .padding(15)
            }
            .scrollIndicators(.hidden)
        }
    }
}

@ViewBuilder
func parallaxCarousel(cards: [Card], height: CGFloat) -> some View {
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
