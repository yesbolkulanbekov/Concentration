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
    private var photoLoader = PhotoLoader()
    private var actionPresenter = ImageSheetPresenter()
    
    override func viewDidLoad() {
        createNewGame()
        
        let chooseButton = UIBarButtonItem(title: "Choose",
                                           style: UIBarButtonItemStyle.plain,
                                           target: self, action: #selector(choose))
        navigationItem.rightBarButtonItem = chooseButton
    }
    
    @IBOutlet private weak var flipCountLabel: UILabel!
    @IBOutlet private var cardButtons: [UIButton]!
    @IBOutlet weak var score: UILabel!
    
    
    
    var numberOfPairsOfCards: Int {
        return (cardButtons.count)/2
    }
    
    @objc func choose() {
        let alert = actionPresenter.pickImage(
        takePicture: CommandWith {
            let camera = self.photoLoader.imagePicker(type: .camera)
            self.present(camera, animated: true, completion: nil)
        },
        choosePicture: CommandWith {
            let library = self.photoLoader.opalPicker()
            self.present(library, animated: true, completion: nil)
        })
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func createNewGame() {
        game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
        game.flipChanged = flipChanged
        game.scoreChanged = scoreChanged
    }
    
    
    @IBAction func startNewGame(_ sender: UIBarButtonItem) {
        createNewGame()
        updateTitles()
        updateViewFromModel()
    }
    
    
    @IBAction private func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender){
            game.chooseCard(at: cardNumber)
//          updateViewFromModel()
            updateViewFromModelWithImages()
        }
    }
    
    private func updateViewFromModelWithImages() {
        for index in cardButtons.indices{
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.imageView?.contentMode = .scaleAspectFit
                button.setImage(photoLoader.pickedImages[0], for: .normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setImage(nil, for: .normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
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








