//
//  MenuViewController.swift
//  Concentration
//
//  Created by Yesbol Kulanbekov on 7/3/18.
//  Copyright © 2018 Yesbol Kulanbekov. All rights reserved.
//

import UIKit


class MenuViewController: UIViewController {
    

    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? ViewController else { return }
        let gameMode = GameMode.init(rawValue: segue.identifier!)!
        destination.gameMode = gameMode
    }
    
}


enum GameMode: String {
    case animals, emojis, friends
}
