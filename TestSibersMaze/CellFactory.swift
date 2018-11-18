//
//  CellFactory.swift
//  TestSibersMaze
//
//  Created by Savely on 14.11.2018.
//  Copyright © 2018 Kulizhnikov. All rights reserved.
//

import UIKit

class CellFactory: NSObject {

    let nameItems = ["Гриб","Кость","Камень"]
    let itemsCount = 4
    let healthChanged = (min: -25, max: 25)
    
    
    func createCell(numberOfItemsPerLineOrColumn: Int) -> ([Item],[(Int,Int)]){
        let randomInt = Int.random(in: 0..<itemsCount)
        var itemStore = [Item]()
        var coordinateStore = [(Int,Int)]()
        var xCoordinate: Int
        var yCoordinate: Int
        var item: Item
        for _ in 0...randomInt {
            let name = nameItems[Int.random(in: 0..<nameItems.count)]
            switch name{
                case "Гриб":
                    item = EatableItem(name: "Гриб",
                                       specification: "This is a mushroom, if you eat it, \n you can get poisoned or increase your health.",
                                       countOfChangedHealth: Int.random(in: healthChanged.min...healthChanged.max))
                    break
                case "Кость":
                     item = Item(name: name,
                                 specification: "This is a bone, this is a useless thing.")
                    break
                case "Камень":
                     item = Item(name: name,
                                 specification: "This is a stone, this is a useless thing.")
                    break
                default:
                     item = Item(name: name,
                                 specification: "This is some kind of, this is a useless thing.")
                    break
            }
            
            itemStore.append(item)
            
            xCoordinate = Int.random(in: 0..<numberOfItemsPerLineOrColumn)
            yCoordinate = Int.random(in: 0..<numberOfItemsPerLineOrColumn)
            while (checkItemSpace(xCoordinate: xCoordinate,
                                  yCoordinate: yCoordinate,
                                  coordinateStore: coordinateStore)) {
                xCoordinate = Int.random(in: 0..<numberOfItemsPerLineOrColumn)
                yCoordinate = Int.random(in: 0..<numberOfItemsPerLineOrColumn)
            }
            coordinateStore.append((yCoordinate,xCoordinate))
        }
        return (itemStore,coordinateStore)
    }
    
    
    func checkItemSpace(xCoordinate: Int, yCoordinate: Int, coordinateStore : [(y: Int, x: Int)]) -> Bool{
        for coordinate in coordinateStore{
            if xCoordinate == coordinate.x && yCoordinate == coordinate.y {
                return true
            }
        }
        return false
    }
}
