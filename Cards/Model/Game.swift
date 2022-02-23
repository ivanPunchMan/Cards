//
//  Game.swift
//  Cards
//
//  Created by Admin on 06.01.2022.
//

import Foundation

class Game {
    var countCards = 0
    var cards = [Card]()
    
    
    func generateCards() {
        var cards = [Card]()
        for _ in 0...countCards {
            let randomElement = (type: CardType.allCases.randomElement()!, color: CardColor.allCases.randomElement()!)
            cards.append(randomElement)
            print("generateCards")
        }
//        return cards
        self.cards = cards
    }
    func checkCards(_ firstCard: Card, _ secondCard: Card) -> Bool {
        if firstCard == secondCard {
            return true
        }
        return false
    }
}
