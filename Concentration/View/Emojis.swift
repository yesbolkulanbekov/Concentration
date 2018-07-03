//
//  Emojis.swift
//  Concentration
//
//  Created by Yesbol Kulanbekov on 7/2/18.
//  Copyright © 2018 Yesbol Kulanbekov. All rights reserved.
//

import Foundation


struct Emojis {
    
    mutating func randomizeEmojis(){
        let theme = Theme()
        emojiChoices = theme.randomTheme
    }
    
    mutating func setEmojis(_ gameMode: GameMode) {
        let theme = Theme()
        switch gameMode {
        case .animals:
            emojiChoices = theme.values[1]
        case .emojis:
            emojiChoices = theme.values[0]
        case .friends:
            emojiChoices = theme.values[0]
        }
    }
    
    private var emojiChoices = Theme().defaultValues
    
    private var emoji = [Card:String]()
    
    mutating func emoji(for card: Card) -> String {
        if emoji[card] == nil, emojiChoices.count > 0 {
            emoji[card] = emojiChoices.remove(at: emojiChoices.count.arc4random)
        }

        return emoji[card] ?? "?"
    }
}
