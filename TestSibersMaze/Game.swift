//
//  Game.swift
//  TestSibersMaze
//
//  Created by Savely on 14.11.2018.
//  Copyright © 2018 Kulizhnikov. All rights reserved.
//

import UIKit

class Game: NSObject {
    private let player: Player
    private let mazeShell: MazeShell
    private var stepCounter: Int
    private var currentPositionOfPlayer: (Int,Int)
    private let mazeSize: (Int,Int)
    
    override init() {
        player = Player()
        mazeShell = MazeShell()
        stepCounter = 0
        currentPositionOfPlayer = (0,0)
        mazeSize = mazeShell.getSize()
    }
    
    
    
    init(maze: MazeShell) {
        player = Player(protocolImplementation: Inventory())
        self.mazeShell = maze
        stepCounter = 0
        currentPositionOfPlayer = (0,0)
        mazeSize = maze.getSize()
    }
    
    func getPlayer() -> Player {
        return player
    }
    
    func getMazeShell() -> MazeShell {
        return mazeShell
    }
    
    func startGame(){
        currentPositionOfPlayer = ((mazeSize.0)/2,(mazeSize.1)/2)
        let cellFactory = CellFactory()
        var coordinates: [(Int,Int)]
        var items: [Item]
        for i in 0..<mazeSize.0 {
            for j in 0..<mazeSize.1{
                (items,coordinates) = cellFactory.createCell(sizeX: 3, sizeY: 3)
                mazeShell.setCell(x: i, y: j, itemStore: items, coordinateStore: coordinates)
            }
        }
        distributeKeyAndChest()
    }
    
    func getStepCounter() -> Int {
        return stepCounter
    }
 
    func getCurrentPositionOfPlayer() -> (Int,Int) {
        return currentPositionOfPlayer
    }
    
    func distributeKeyAndChest(){
        let key = Key(name: "Ключ", descript: "This is the key - he opens the chest", identifier: "1")
        var xCellCoordinate = Int.random(in: 0...mazeSize.1-1)
        var yCellCoordinate = Int.random(in: 0...mazeSize.0-1)
        
        mazeShell.getMaze()[yCellCoordinate][xCellCoordinate].addItemAndCoordinate(item: key, coordinate: searchEptySpace(cell: mazeShell.getMaze()[yCellCoordinate][xCellCoordinate]))
    
        print("\(xCellCoordinate) Key \(yCellCoordinate)")
        
        xCellCoordinate = Int.random(in: 0...mazeSize.1-1)
        yCellCoordinate = Int.random(in: 0...mazeSize.0-1)
        
        let chest = Chest(name: "Сундук", descript: "This is a chest - opens with a key", keyIdentifier: "1")
        
        mazeShell.getMaze()[yCellCoordinate][xCellCoordinate].addItemAndCoordinate(item: chest, coordinate: searchEptySpace(cell: mazeShell.getMaze()[yCellCoordinate][xCellCoordinate]))
        print("\(xCellCoordinate) chest \(yCellCoordinate)")
    }
    
    
    
    func searchEptySpace(cell: Cell) -> (Int,Int){
        var xCoordinate = Int.random(in: 0...2)
        var yCoordinate = Int.random(in: 0...2)
        while (checkItemSpace(xCoordinate: xCoordinate, yCoordinate: yCoordinate,
                              coordinateStore: cell.getItemsCoordinates())){
                                xCoordinate = Int.random(in: 0...2)
                                yCoordinate = Int.random(in: 0...2)
        }
        return (yCoordinate,xCoordinate)
    }
    
    func checkItemSpace(xCoordinate: Int, yCoordinate: Int, coordinateStore : [(Int,Int)]) -> Bool{
        for coordinate in coordinateStore{
            if xCoordinate == coordinate.1 && yCoordinate == coordinate.0 {
                return true
            }
        }
        return false
    }
    
    func nextStep(direction: String) -> Bool{
        if player.changeHealth(much: -1){
            return true
        }
        stepCounter += 1
        switch direction {
        case "Up":
            currentPositionOfPlayer.0 -= 1
            break
        case"Down":
            currentPositionOfPlayer.0 += 1
            break
        case "Right":
            currentPositionOfPlayer.1 += 1
            break
        case "Left":
            currentPositionOfPlayer.1 -= 1
            break
        default:
            print("Incorrect direction")
        }
        return false
    }
    
    func raiseItem(name: String, cellCoordinate: (Int,Int), itemCoordinate: (Int,Int)){
        let cell = mazeShell.getMaze()[cellCoordinate.0][cellCoordinate.1]
        
        var i = 0;
        while cell.getItemsCoordinates()[i] != itemCoordinate {
            i += 1
        }
        let item = cell.removeItem(index: i)
        player.getInventory().putItem(item: item)
    }
    
    func dropItem(index: Int, cellCoordinate: (Int,Int)) -> (Bool,String){
        let cell = mazeShell.getMaze()[cellCoordinate.0][cellCoordinate.1]
        if (index != -1){
            if cell.getItemsInRoom().count>8 {
                return (true, "No space")
            }
            let item = player.getInventory().dropItemAt(number: index)
            cell.addItem(item: item)
            return (false, "Ok")
        } else{
            return (true, "You must select an item")
        }
        
    }
    
   
    
    
}
