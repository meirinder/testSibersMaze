//
//  Chest.swift
//  TestSibersMaze
//
//  Created by Savely on 15.11.2018.
//  Copyright © 2018 Kulizhnikov. All rights reserved.
//

import UIKit

class Chest: Item {

    let keyIdentifier: String
    
    init(name: String, descript: String, keyIdentifier: String) {
        self.keyIdentifier = keyIdentifier
        super.init(name: name, descript: descript)
    }
    
    
    
}
