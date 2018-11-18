//
//  Inventory.swift
//  TestSibersMaze
//
//  Created by Savely on 14.11.2018.
//  Copyright © 2018 Kulizhnikov. All rights reserved.
//

import UIKit

class Inventory: NSObject {
    
    private var itemStore: [Item]
    
    override init() {
        itemStore = []
    }
    
    
    
}

extension Inventory : InventoryProtocol{
    func dropItemAt(number: Int) -> Item {
        let item = itemStore[number]
        itemStore.remove(at: number)
        return item
    }
    
    
    func putItem(item: Item) {
        itemStore.append(item)
    }
    
    
    func removeItemAt(number: Int){
         itemStore.remove(at: number)
    }
    
    
    func getItemStore() -> [Item]{
        return itemStore
    }
}
