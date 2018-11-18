//
//  Player.swift
//  TestSibersMaze
//
//  Created by Savely on 14.11.2018.
//  Copyright © 2018 Kulizhnikov. All rights reserved.
//

import UIKit

class Player: NSObject {

    private let inventory: InventoryProtocol
    private var health: Int
    private var selctedItemInInventory: Int
    let maxHealth = 100
    
    override init() {
        inventory = Inventory()
        health = 0
        selctedItemInInventory = -1
    }
    
    
    func getHealth() -> Int {
        return health
    }
    
    
    func changeHealth(much: Int) -> Bool {
        health += much
        if health < 0 {
            return true
        }
        if health > maxHealth{
            health = maxHealth
        }
        return false
    }
    
    
    init(protocolImplementation: InventoryProtocol ) {
        self.inventory = protocolImplementation
        self.health = maxHealth
        self.selctedItemInInventory = -1
    }
    
    
    func setSelctedItemInInventory(index: Int) {
        selctedItemInInventory = index
    }
    
    
    func getSelctedItemInInventory() -> Int {
        return selctedItemInInventory
    }
    
    
    func getInventory() -> InventoryProtocol {
        return inventory
    }
}

extension Player: PlayerProtocol{
    func openChest(key: Key, chest: Chest) -> Bool {
        if key.identifier == chest.keyIdentifier {
            return true
        }else{
            print("Неверный ключ")
        }
        return false
    }
    
    
    func discardItem()  -> Bool {
        if selctedItemInInventory != -1 {
            inventory.removeItemAt(number: selctedItemInInventory)
            return false
        }
        return true
    }
    
    
    func useItem() -> (successfulExecution: Bool, type: String, code: Int){
        if selctedItemInInventory != -1 {
            let item = inventory.getItemStore()[selctedItemInInventory]
            switch item {
            case is EatableItem:
                if changeHealth(much: (item as! EatableItem).countOfChangedHealth) {
                    return(true,"",-2)
                }
                _ = discardItem()
                return (false,"Eat",(item as! EatableItem).countOfChangedHealth)
            case is Key:
                return(false,"Key",0)
            default:
                break
            }
            
        }
        return (true,"",-1)
    }
    
}
