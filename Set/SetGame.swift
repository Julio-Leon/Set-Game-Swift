//
//  SetGame.swift
//  Set
//
//  Created by Julio leon on 3/6/23.
//

import Foundation

struct SetGame {
    private let numberOfCardsInANewGame = 12
    private var deck: SetDeck
    var cards = [SetCard]()
    var score = 0
    var won = false
    
    var currentlySelectedCards = [Int]()
    
    mutating func addThreeCards () {
        for _ in 0..<3 {
            if let setCard = self.deck.dealCard() {
                cards.append(setCard)
            }
        }
    }
    
    mutating func checkForWin() -> Bool {
        
        let cardOne = cards.first(where: {$0.id == currentlySelectedCards[0]})
        let cardTwo = cards.first(where: {$0.id == currentlySelectedCards[1]})
        let cardThree = cards.first(where: {$0.id == currentlySelectedCards[2]})
        
        var shapeSetFound = false
        var colorSetFound = false
        var shadeSetFound = false
        var countSetFound = false
        
        if (cardOne?.shape == cardTwo?.shape && cardTwo?.shape == cardThree?.shape)
            || (cardOne?.shape != cardTwo?.shape && cardTwo?.shape != cardThree?.shape && cardOne?.shape != cardThree?.shape) {
            shapeSetFound = true
        }
        
        if (cardOne?.color == cardTwo?.color && cardTwo?.color == cardThree?.color)
            || (cardOne?.color != cardTwo?.color && cardTwo?.color != cardThree?.color && cardOne?.color != cardThree?.color) {
            colorSetFound = true
        }

        if (cardOne?.shade == cardTwo?.shade && cardTwo?.shade == cardThree?.shade)
            || (cardOne?.shade != cardTwo?.shade && cardTwo?.shade != cardThree?.shade && cardOne?.shade != cardThree?.shade) {
            shadeSetFound = true
        }
        
        if (cardOne?.count == cardTwo?.count && cardTwo?.count == cardThree?.count)
            || (cardOne?.count != cardTwo?.count && cardTwo?.count != cardThree?.count && cardOne?.count != cardThree?.count) {
            countSetFound = true
        }
        
        if shapeSetFound && colorSetFound && shadeSetFound && countSetFound {
            score += 1
            return true
        }
        return false
    }
    
    mutating func selectCard (card: SetCard) {
        if let currentCardIndex = cards.firstIndex(where: {$0.id == card.id}) {
            
            if currentlySelectedCards.count >= 3 {
                
                if checkForWin() {
                    if cards[currentCardIndex].isSelected {
                        replaceThreeCards()
                        unselectAllCards()
                    } else {
                        replaceThreeCards()
                        select(currentCardIndex)
                    }
                }
                else {
                    if cards[currentCardIndex].isSelected {
                        unselectAllCards()
                    } else {
                        unselectAllCards()
                        select(currentCardIndex)
                    }
                }
                
            } else {
                if cards[currentCardIndex].isSelected {
                    unselect(currentCardIndex)
                } else {
                    select(currentCardIndex)
                }
            }
        }
    }
    
    mutating func replaceThreeCards () {
        for i in 0..<currentlySelectedCards.count {
            cards.removeAll(where: {card in card.id == currentlySelectedCards[i]})
        }
        addThreeCards()
    }
    
    mutating func select (_ i: Int) {
        cards[i].isSelected = true
        currentlySelectedCards.append(cards[i].id)
    }
    
    mutating func unselect (_ i: Int) {
        cards[i].isSelected = false
        currentlySelectedCards.removeAll(where: {id in cards[i].id == id})
    }
 
    mutating func unselectAllCards () {
        for i in 0..<cards.count {
            unselect(i)
        }
    }
    
    func getDeck() -> [SetCard] {
        return self.cards
    }
    
    init () {
        self.deck = SetDeck()
        
        for _ in 0..<numberOfCardsInANewGame {
            if let setCard = self.deck.dealCard() {
                cards.append(setCard)
            }
        }
    }
}
