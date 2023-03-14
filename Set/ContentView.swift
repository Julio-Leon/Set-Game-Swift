//
//  ContentView.swift
//  Set
//
//  Created by Julio leon on 3/6/23.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel: SetViewModel
    
    var body: some View {
        
        let gameCards: [SetCard] = viewModel.cards
        VStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 67))]) {
                    ForEach(gameCards) { card in
                        CardView(card)
                            .aspectRatio(2/3, contentMode: .fill)
                            .onTapGesture {
                                viewModel.selectCard(card)
                            }
                    }
                }
                .padding(.horizontal)
            }
            HStack {
                Spacer()
                Button("Add 3 Cards!") {
                    viewModel.addThreeCards()
                }
                .padding()
                
                Spacer()
                
                Button ("↻") {
                    viewModel.restartGame()
                }
                .padding()
                .frame(width: 50)
            }
        }
    }
}

struct CardView: View {
    
    let card: SetCard
    let cardColor: Color
    
    init(_ card: SetCard) {
        self.card = card
        
        switch self.card.color {
        case .green:
            cardColor = Color(.green)
        case .purple:
            cardColor = Color(.purple)
        case .red:
            cardColor = Color(.red)
        }
    }
    
    var body: some View {
        
        ZStack(alignment: .center) {
            let shape = RoundedRectangle(cornerRadius: 15)
        
            shape
                .fill()
                .opacity(0.5)
                .addBorder(card.isSelected ? Color.black : Color.white, width: 3.5, cornerRadius: 15)
                .foregroundColor(.black)
                
            Text(card.getCardContent())
                .font(.title)
                .frame(width: 40, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .opacity(card.shade == .shaded ? 0.3 : 1)
                .foregroundColor(cardColor)
        }
    }
}

extension View {
    public func addBorder<S>(_ content: S, width: CGFloat = 1, cornerRadius: CGFloat) -> some View where S : ShapeStyle {
        let roundedRect = RoundedRectangle(cornerRadius: cornerRadius)
        return clipShape(roundedRect)
             .overlay(roundedRect.strokeBorder(content, lineWidth: width))
    }
}
// By @kontiki at " https://swiftui-lab.com/view-extensions-for-better-code-readability/ "
// Makes the color drawing of the RoundedRectangle's rounded border easier, and in my case it made this possible

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = SetViewModel()
        ContentView(viewModel: game)
    }
}

