//
//  Key.swift
//  TestSibersMaze
//
//  Created by Savely on 15.11.2018.
//  Copyright © 2018 Kulizhnikov. All rights reserved.
//


class Key: Item {

    let identifier: String
    
    init(name: String, specification: String, identifier: String) {
        self.identifier = identifier
        super.init(name: name,
                   specification: specification)
    }
    
}
