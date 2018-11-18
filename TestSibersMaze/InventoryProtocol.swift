//
//  InventoryProtocol.swift
//  TestSibersMaze
//
//  Created by Savely on 14.11.2018.
//  Copyright © 2018 Kulizhnikov. All rights reserved.
//


protocol InventoryProtocol {
    
    func dropItemAt(number: Int) -> Item
    func putItem(item: Item)
    func getItemStore() -> [Item]
    func removeItemAt(number: Int)
    
}
