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
    private var emojis = Emojis()

    override func viewDidLoad() {
        createNewGame()
    }
    
    @IBOutlet private weak var flipCountLabel: UILabel!
    @IBOutlet private var cardButtons: [UIButton]!
    @IBOutlet weak var score: UILabel!

    
    
    var numberOfPairsOfCards: Int {
        return (cardButtons.count)/2
    }
    
    
    func createNewGame() {
        game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
        game.flipChanged = flipChanged
        game.scoreChanged = scoreChanged
    }

    
    @IBAction func startNewGame(_ sender: UIBarButtonItem) {
        createNewGame()
        updateTitles()
        emojis.randomizeEmojis()
        updateViewFromModel()
    }

    
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
                button.setTitle(emojis.emoji(for: card), for: .normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
                
            }
        }
    }
    
    func updateTitles() {
        flipChanged()
        scoreChanged()
    }
    
    func flipChanged() {
        flipCountLabel.text = "Flips : \( self.game.flipCount)"
    }
    
    func scoreChanged() {
        score.text = "Score : \( self.game.score)"
    }

    
}








