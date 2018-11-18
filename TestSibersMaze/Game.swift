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
    private var currentPositionOfPlayer: (y: Int, x: Int)
    private let mazeSize: (y: Int, x: Int)
    let numberOfItemsPerLineOrColumn = 3
    let maxItemCountInCell = 9
    
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
    
    
    func startGame() {
        currentPositionOfPlayer = ((mazeSize.y)/2,(mazeSize.x)/2)
        let cellFactory = CellFactory()
        var coordinates: [(Int,Int)]
        var items: [Item]
        for i in 0..<mazeSize.y {
            for j in 0..<mazeSize.x {
                (items,coordinates) = cellFactory.createCell(numberOfItemsPerLineOrColumn: numberOfItemsPerLineOrColumn)
                mazeShell.setCell(x: i,
                                  y: j,
                                  itemStore: items,
                                  coordinateStore: coordinates)
            }
        }
        distributeKeyAndChest()
    }
    
    
    func getStepCounter() -> Int {
        return stepCounter
    }
 
    
    func getCurrentPositionOfPlayer() -> (y: Int,x: Int) {
        return currentPositionOfPlayer
    }
    
    
    func distributeKeyAndChest() {
        let key = Key(name: "Ключ",
                      specification: "This is the key - he opens the chest",
                      identifier: "1")
        var xCellCoordinate = Int.random(in: 0..<mazeSize.x)
        var yCellCoordinate = Int.random(in: 0..<mazeSize.y)
        
        mazeShell.getMaze()[yCellCoordinate][xCellCoordinate].addItemAndCoordinate(item: key,
                                                                                   coordinate: searchEptySpace(cell: mazeShell.getMaze()[yCellCoordinate][xCellCoordinate], cellSize: (3,3)))
        print("\(xCellCoordinate) Key \(yCellCoordinate)")
        xCellCoordinate = Int.random(in: 0..<mazeSize.x)
        yCellCoordinate = Int.random(in: 0..<mazeSize.y)
        let chest = Chest(name: "Сундук",
                          specification: "This is a chest - opens with a key",
                          keyIdentifier: "1")
        
        mazeShell.getMaze()[yCellCoordinate][xCellCoordinate].addItemAndCoordinate(item: chest, coordinate: searchEptySpace(cell: mazeShell.getMaze()[yCellCoordinate][xCellCoordinate],cellSize: (3,3)))
        print("\(xCellCoordinate) chest \(yCellCoordinate)")
    }
    
    
    func searchEptySpace(cell: Cell, cellSize: (y: Int, x: Int)) -> (Int,Int) {
        var xCoordinate = Int.random(in: 0..<numberOfItemsPerLineOrColumn)
        var yCoordinate = Int.random(in: 0..<numberOfItemsPerLineOrColumn)
        while (checkItemSpace(xCoordinate: xCoordinate,
                              yCoordinate: yCoordinate,
                              coordinateStore: cell.getItemsCoordinates())) {
                                xCoordinate = Int.random(in: 0..<numberOfItemsPerLineOrColumn)
                                yCoordinate = Int.random(in: 0..<numberOfItemsPerLineOrColumn)
        }
        return (yCoordinate,xCoordinate)
    }
    
    
    func checkItemSpace(xCoordinate: Int, yCoordinate: Int, coordinateStore : [(y: Int, x: Int)]) -> Bool {
        for coordinate in coordinateStore {
            if xCoordinate == coordinate.x && yCoordinate == coordinate.y {
                return true
            }
        }
        return false
    }
    
    
    func nextStep(direction: String) -> Bool {
        if player.changeHealth(much: -1) {
            return true
        }
        stepCounter += 1
        switch direction {
        case "Up":
            currentPositionOfPlayer.y -= 1
            break
        case"Down":
            currentPositionOfPlayer.y += 1
            break
        case "Right":
            currentPositionOfPlayer.x += 1
            break
        case "Left":
            currentPositionOfPlayer.x -= 1
            break
        default:
            print("Incorrect direction")
        }
        return false
    }
    
    
    func raiseItem(name: String, cellCoordinate: (y: Int, x: Int), itemCoordinate: (y: Int, x: Int)) {
        let cell = mazeShell.getMaze()[cellCoordinate.y][cellCoordinate.x]
        var i = 0;
        while cell.getItemsCoordinates()[i] != itemCoordinate {
            i += 1
        }
        let item = cell.removeItem(index: i)
        player.getInventory().putItem(item: item)
    }
    
    
    func dropItem(index: Int, cellCoordinate: (y: Int, x: Int)) -> (error: Bool, typeOfError: String) {
        let cell = mazeShell.getMaze()[cellCoordinate.y][cellCoordinate.x]
        if (index != -1) {
            if cell.getItemsInRoom().count >= maxItemCountInCell {
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
