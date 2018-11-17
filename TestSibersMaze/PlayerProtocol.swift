//
//  PlayerProtocol.swift
//  TestSibersMaze
//
//  Created by Savely on 14.11.2018.
//  Copyright © 2018 Kulizhnikov. All rights reserved.
//

import Foundation

protocol PlayerProtocol {
    func discardItem()  -> Bool 
    func useItem()  -> (Bool,String,Int)
    func openChest(key: Key, chest: Chest) -> Bool
}
