//
//  Themes.swift
//  Concentration
//
//  Created by Yesbol Kulanbekov on 6/23/18.
//  Copyright © 2018 Yesbol Kulanbekov. All rights reserved.
//

import Foundation


struct Theme {
    
    var defaultValues: [String] {
        return values[0]
    }
    
    var randomTheme: [String] {
        return values[values.count.arc4random]
    }
    
    var values = [[String]]()
    
    init() {
        values.append(["😀", "😃", "😄", "😁", "😆", "😅", "😂", "🤣",
                       "☺️", "😊", "😇", "🙂", "🙃", "😉", "😌", "😍",
                       "😘", "😗", "😚", "😋", "😜", "😝", "😙", "😛",
                       "👿", "👹", "👺", "💩", "👻", "💀", "🤖", "🎃",])
        values.append(["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼",
                       "🐨", "🐯", "🦁", "🐮", "🐷", "🐽", "🐸", "🐵",
                       "🙈", "🐧", "🐦", "🦅", "🐗", "🐺", "🦇", "🦉",
                       "🐴", "🐌", "🦄", "🦂", "🦀", "🐪", "🐳", "🍄"])
    }
}
