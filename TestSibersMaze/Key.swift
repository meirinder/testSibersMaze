//
//  Key.swift
//  TestSibersMaze
//
//  Created by Savely on 15.11.2018.
//  Copyright © 2018 Kulizhnikov. All rights reserved.
//

import UIKit

class Key: Item {

    let identifier: String
    
    init(name: String, descript: String, identifier: String) {
        self.identifier = identifier
        super.init(name: name, descript: descript)
    }
    
}
