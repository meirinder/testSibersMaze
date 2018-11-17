//
//  Cell.swift
//  TestSibersMaze
//
//  Created by Savely on 13.11.2018.
//  Copyright © 2018 Kulizhnikov. All rights reserved.
//

import UIKit

class Cell: NSObject   {
    
    
    private var rightWall: Bool
    private var leftWall: Bool
    private var downWall: Bool
    private var upWall: Bool
    private let sizeOfCell: (Int,Int)
    private var itemsInRoom: [Item]
    private var itemsCoordinates: [(Int,Int)]
    var variety : Int
    
    override init() {
        self.variety = 0;
        self.rightWall = false
        self.leftWall = false
        self.downWall = false
        self.upWall = false
        self.itemsInRoom = []
        self.sizeOfCell = (3,3)
        self.itemsCoordinates = []
    }
    
    init(rightWall: Bool, leftWall: Bool, upWall: Bool, downWall: Bool, variety: Int = 0) {
        self.variety = variety;
        self.rightWall = rightWall
        self.leftWall = leftWall
        self.downWall = downWall
        self.upWall = upWall
        self.itemsInRoom = []
        self.sizeOfCell = (3,3)
        self.itemsCoordinates = []
    }
    
    func addItem(item: Item){
        var randomX = Int.random(in: 0...2)
        var randomY = Int.random(in: 0...2)
        while checkEmptySpace(xCoordinate: randomX, yCoordinate: randomY) {
            randomX = Int.random(in: 0...2)
            randomY = Int.random(in: 0...2)
        }
        itemsCoordinates.append((randomY,randomX))
        itemsInRoom.append(item)
    }
    
    func checkEmptySpace(xCoordinate: Int, yCoordinate: Int) -> Bool{
        for coordinate in itemsCoordinates{
            if xCoordinate == coordinate.1 && yCoordinate == coordinate.0 {
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
    
    
    func hasChest() -> Bool{
        for item in itemsInRoom{
            if "Сундук" == item.name{
                return true
            }
        }
        return false
    }
    
    
    func getItemsCoordinates() -> [(Int,Int)] {
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
    
    func setWalls(rightWall: Bool, leftWall: Bool, upWall: Bool, downWall: Bool){
        self.rightWall = rightWall
        self.leftWall = leftWall
        self.downWall = downWall
        self.upWall = upWall
    }
    
    func setRightWall(rightWall: Bool){
        self.rightWall = rightWall
    }
    
    func setLeftWall(leftWall: Bool){
        self.leftWall = leftWall
    }
    
    func setUpWall(upWall: Bool){
        self.upWall = upWall
    }
    
    func setDownWall(downWall: Bool){
        self.downWall = downWall
    }
    
    func getDownWall() -> Bool{
        return self.downWall
    }
    
    func getUpWall() -> Bool{
        return self.upWall
    }
    
    func getRightWall() -> Bool{
        return self.rightWall
    }
    
    func getLeftWall() -> Bool{
        return self.leftWall
    }
    
    
}

extension Cell: NSCopying{
    func copy(with zone: NSZone? = nil) -> Any {
        let copy  = Cell(rightWall: rightWall, leftWall: leftWall, upWall: upWall, downWall: downWall, variety: variety)
        return copy
    }
}
