//
//  SetDeck.swift
//  Set
//
//  Created by Julio leon on 3/6/23.
//

import Foundation

struct SetDeck {
    private var deck = [SetCard]()
    
    func count () -> Int {
        self.deck.count
    }

    func isEmpty () -> Bool {
        self.deck.count == 0
    }

    mutating func dealCard () -> SetCard? {
        if (self.isEmpty()) {
            return nil
        } else {
            return self.deck.remove(at: 0)
        }
    }
    
    init() {
        var id = 1
        for color in SetCard.Colors.all {
            for shape in SetCard.Shapes.all {
                for shade in SetCard.Shades.all {
                    for count in 1...3 {
                        self.deck.append(SetCard(
                            shape: shape,
                            shade: shade,
                            color: color,
                            count: count,
                            id: id
                        ))
                    id += 1
                    }
                }
            }
        }
        self.deck.shuffle()
        self.deck.shuffle()
        self.deck.shuffle()
    }
}
