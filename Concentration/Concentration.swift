//
//  Concentration.swift
//  Concentration
//
//  Created by Yesbol Kulanbekov on 11/19/17.
//  Copyright © 2017 Yesbol Kulanbekov. All rights reserved.
//

import Foundation

class Concentration {
    
    var flipChanged = { }
    var scoreChanged = { }
    
    private(set) var cards = [Card]()
    private(set) var flipCount = 0 {
        didSet {
            flipChanged()
        }
    }
    
    private(set) var score = 0 {
        didSet {
            scoreChanged()
        }
    }
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            return cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly
        }
        set  {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    var openedCards = [Int]()
    
    func addToOpenedCards(_ index: Int) {
        guard index != indexOfOneAndOnlyFaceUpCard else { return }
        guard !openedCards.contains(index) else {
            score -= 1
            return
        }
        openedCards.append(index)
    }
    
    func increaseFlip(_ index: Int) {
        guard index != indexOfOneAndOnlyFaceUpCard else { return }
        flipCount += 1
    }
    
    func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index not in the cards")
        if !cards[index].isMatched {
            increaseFlip(index)
            if let matchedIndex = indexOfOneAndOnlyFaceUpCard, matchedIndex != index {

                if cards[matchedIndex] == cards[index] {
                    cards[matchedIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 2
                } else {
                    addToOpenedCards(index)
                }
                cards[index].isFaceUp = true
                
            } else {
                addToOpenedCards(index)
                indexOfOneAndOnlyFaceUpCard = index
            }
            
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "Concentration.init(at: \(numberOfPairsOfCards)): you must have at least one pair of cards")
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card,card]
        }
        var randomizedCards = [Card]()
    
        repeat {
            let removed = cards.remove(at: cards.count.arc4random)
            randomizedCards.append(removed)
        } while !cards.isEmpty

        cards = randomizedCards
        

        
    }
}




extension Collection {
    
    var oneAndOnly: Element? {
        return count == 1 ? first: nil
    }
    
}





