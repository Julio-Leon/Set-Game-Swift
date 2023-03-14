//
//  SetViewModel.swift
//  Set
//
//  Created by Julio leon on 3/10/23.
//

import SwiftUI

class SetViewModel: ObservableObject {
    
    @Published private var gameModel = SetGame()
    
    var cards: [SetCard] {
        let _ = print(gameModel.getDeck())
        return gameModel.getDeck()
    }
    
    func selectCard (_ card: SetCard) {
        gameModel.selectCard(card: card)
    }
    
    func addThreeCards () {
        gameModel.addThreeCards()
    }
    
    func restartGame () {
        gameModel = SetGame()
    }
    
}
