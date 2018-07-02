//
//  Card.swift
//  Concentration
//
//  Created by Yesbol Kulanbekov on 11/19/17.
//  Copyright © 2017 Yesbol Kulanbekov. All rights reserved.
//

import Foundation

struct Card{
    var isFaceUp = false
    var isMatched = false
    private var identifier: Int
    
    private static var identifierFactory = 0
    
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}


extension Card: Hashable {
    var hashValue: Int {
        return identifier
    }
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
}
