//
//  EatableItem.swift
//  TestSibersMaze
//
//  Created by Savely on 14.11.2018.
//  Copyright © 2018 Kulizhnikov. All rights reserved.
//



class EatableItem: Item {

    let countOfChangedHealth: Int
    
    init(name: String, specification: String, countOfChangedHealth: Int) {
        self.countOfChangedHealth = countOfChangedHealth
        super.init(name: name,
                   specification: specification)
    }
    
    
}
