//
//  ViewController.swift
//  Concentration
//
//  Created by Yesbol Kulanbekov on 11/15/17.
//  Copyright © 2017 Yesbol Kulanbekov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private var game:Concentration!

    
    var numberOfPairsOfCards: Int {
        return (cardButtons.count)/2
    }
    
    func flipChanged() {
        flipCountLabel.text = "Flips : \( self.game.flipCount)"
    }
    
    func scoreChanged() {
        score.text = "Score : \( self.game.score)"
    }
    
    override func viewDidLoad() {
        createNewGame()
    }
    
    func createNewGame() {
        game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
        game.flipChanged = flipChanged
        game.scoreChanged = scoreChanged
    }

    @IBOutlet weak var score: UILabel!
    
    @IBAction func startNewGame(_ sender: UIBarButtonItem) {
        createNewGame()
        flipChanged()
        scoreChanged()
        emojiChoices = Theme().values[Theme().values.count.arc4random]
        updateViewFromModel()
    }
    
    @IBOutlet private weak var flipCountLabel: UILabel!
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBAction private func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender){
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
    }
    
    private func updateViewFromModel() {
        for index in cardButtons.indices{
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: .normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
                
            }
        }
    }
    private var emojiChoices = Theme().values[0]
  
    private var emoji = [Card:String]()

    
    private func emoji(for card: Card) -> String {
        if emoji[card] == nil, emojiChoices.count > 0 {
            emoji[card] = emojiChoices.remove(at: emojiChoices.count.arc4random)
        }
        return emoji[card] ?? "?"
    }
    
}




extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}



