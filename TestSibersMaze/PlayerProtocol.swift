//
//  PlayerProtocol.swift
//  TestSibersMaze
//
//  Created by Savely on 14.11.2018.
//  Copyright © 2018 Kulizhnikov. All rights reserved.
//



protocol PlayerProtocol {
    
    func discardItem()  -> Bool 
    func useItem()  -> (successfulExecution: Bool, type: String, code: Int)
    func openChest(key: Key, chest: Chest) -> Bool
    
}
