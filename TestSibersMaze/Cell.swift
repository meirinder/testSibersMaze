//
//  Cell.swift
//  TestSibersMaze
//
//  Created by Savely on 13.11.2018.
//  Copyright © 2018 Kulizhnikov. All rights reserved.
//

import UIKit

class Cell: NSObject {
    
    
    private var presenceOfTheRightWall: Bool
    private var presenceOfTheLeftWall: Bool
    private var presenceOfTheBottomWall: Bool
    private var presenceOfTheTopWall: Bool
    private let sizeOfCell: (y: Int, x: Int)
    private var itemsInRoom: [Item]
    private var itemsCoordinates: [(y: Int, x: Int)]
    var variety : Int
    
    override init() {
        self.variety = 0
        self.presenceOfTheRightWall = false
        self.presenceOfTheLeftWall = false
        self.presenceOfTheBottomWall = false
        self.presenceOfTheTopWall = false
        self.itemsInRoom = []
        self.sizeOfCell = (3,3)
        self.itemsCoordinates = []
    }
    
    
    init(rightWall: Bool, leftWall: Bool, upWall: Bool, downWall: Bool, variety: Int = 0) {
        self.variety = variety
        self.presenceOfTheRightWall = rightWall
        self.presenceOfTheLeftWall = leftWall
        self.presenceOfTheBottomWall = downWall
        self.presenceOfTheTopWall = upWall
        self.itemsInRoom = []
        self.sizeOfCell = (3,3)
        self.itemsCoordinates = []
    }
    
    
    func addItem(item: Item) {
        var randomX = Int.random(in: 0..<sizeOfCell.x)
        var randomY = Int.random(in: 0..<sizeOfCell.y)
        while checkEmptySpace(xCoordinate: randomX, yCoordinate: randomY) {
            randomX = Int.random(in: 0..<sizeOfCell.x)
            randomY = Int.random(in: 0..<sizeOfCell.y)
        }
        itemsCoordinates.append((randomY,randomX))
        itemsInRoom.append(item)
    }
    
    
    func checkEmptySpace(xCoordinate: Int, yCoordinate: Int) -> Bool {
        for coordinate in itemsCoordinates {
            if xCoordinate == coordinate.x && yCoordinate == coordinate.y {
                return true
            }
        }
        return false
    }
    
    
    func removeItem(index: Int) -> Item {
        let res = itemsInRoom[index]
        itemsInRoom.remove(at: index)
        itemsCoordinates.remove(at: index)
        return res
    }
    
    
    func hasChest() -> Bool {
        for item in itemsInRoom {
            if "Сундук" == item.name {
                return true
            }
        }
        return false
    }
    
    
    func getItemsCoordinates() -> [(y: Int, x: Int)] {
        return itemsCoordinates
    }
    
    
    func addItemAndCoordinate(item: Item, coordinate: (Int,Int)) {
        itemsInRoom.append(item)
        itemsCoordinates.append(coordinate)
    }
    
    
    func getItemsInRoom() -> [Item] {
        return itemsInRoom
    }
    
    
    func setItemsInRoom(itemStore: [Item], coordinatesStore: [(Int,Int)]) {
        self.itemsInRoom = itemStore
        self.itemsCoordinates = coordinatesStore
    }
    
    
    func setWalls(presenceOfTheRightWall: Bool, presenceOfTheLeftWall: Bool, presenceOfTheTopWall: Bool, presenceOfTheBottomWall: Bool) {
        self.presenceOfTheRightWall = presenceOfTheRightWall
        self.presenceOfTheLeftWall = presenceOfTheLeftWall
        self.presenceOfTheBottomWall = presenceOfTheBottomWall
        self.presenceOfTheTopWall = presenceOfTheTopWall
    }
    
    
    func setRightWall(presenceOfTheRightWall: Bool) {
        self.presenceOfTheRightWall = presenceOfTheRightWall
    }
    
    
    func setLeftWall(presenceOfTheLeftWall: Bool) {
        self.presenceOfTheLeftWall = presenceOfTheLeftWall
    }
    
    
    func setUpWall(presenceOfTheTopWall: Bool) {
        self.presenceOfTheTopWall = presenceOfTheTopWall
    }
    
    
    func setDownWall(presenceOfTheBottomWall: Bool) {
        self.presenceOfTheBottomWall = presenceOfTheBottomWall
    }
    
    
    func getDownWall() -> Bool {
        return self.presenceOfTheBottomWall
    }
    
    
    func getUpWall() -> Bool {
        return self.presenceOfTheTopWall
    }
    
    
    func getRightWall() -> Bool {
        return self.presenceOfTheRightWall
    }
    
    
    func getLeftWall() -> Bool {
        return self.presenceOfTheLeftWall
    }
}

extension Cell: NSCopying {
    func copy(with zone: NSZone? = nil) -> Any {
        let copy  = Cell(rightWall: presenceOfTheRightWall,
                         leftWall: presenceOfTheLeftWall,
                         upWall: presenceOfTheTopWall,
                         downWall: presenceOfTheBottomWall,
                         variety: variety)
        return copy
    }
}
