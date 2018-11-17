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
    
    
    
    func createCell(sizeX: Int, sizeY: Int) -> ([Item],[(Int,Int)]){
        let randomInt = Int.random(in: 0...3)
        var itemStore = [Item]()
        var coordinateStore = [(Int,Int)]()
        var xCoordinate: Int
        var yCoordinate: Int
        var item: Item
        for _ in 0...randomInt{
            let name = nameItems[Int.random(in: 0...2)]
            switch name{
                case "Гриб":
                    item = EatableItem(name: "Гриб", descript: "This is a mushroom, if you eat it, you can get poisoned.", countOfChangedHealth: -25)
                break
                case "Кость":
                     item = Item(name: nameItems[Int.random(in: 1...2)], descript: "This is a bone, this is a useless thing.")
                break
                case "Камень":
                     item = Item(name: nameItems[Int.random(in: 1...2)], descript: "This is a stone, this is a useless thing.")
                break
                default:
                     item = Item(name: nameItems[Int.random(in: 1...2)], descript: "This is some kind of, this is a useless thing.")
                break
            }
            
            itemStore.append(item)
            
            
            xCoordinate = Int.random(in: 0..<sizeX)
            yCoordinate = Int.random(in: 0..<sizeY)
            while (checkItemSpace(xCoordinate: xCoordinate, yCoordinate: yCoordinate,
                                  coordinateStore: coordinateStore)){
                xCoordinate = Int.random(in: 0..<sizeX)
                yCoordinate = Int.random(in: 0..<sizeY)
            }
            coordinateStore.append((xCoordinate,yCoordinate))
        }
        return (itemStore,coordinateStore)
    }
    
    func checkItemSpace(xCoordinate: Int, yCoordinate: Int, coordinateStore : [(Int,Int)]) -> Bool{
        for coordinate in coordinateStore{
            if xCoordinate == coordinate.1 && yCoordinate == coordinate.0 {
                return true
            }
        }
        return false
    }
}
