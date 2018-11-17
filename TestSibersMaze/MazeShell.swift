//
//  Maze.swift
//  TestSibersMaze
//
//  Created by Savely on 13.11.2018.
//  Copyright © 2018 Kulizhnikov. All rights reserved.
//

import UIKit

class MazeShell: NSObject {
    private var maze: [[Cell]]
    private let M: Int
    private let N: Int
    
    override init() {
        self.M = 0
        self.N = 0
        self.maze = []
    }
    
    init(M: Int , N: Int ) {
        self.M = M
        self.N = N
        var newMaze : [[Cell]] = []
        for i in 0..<M {
            newMaze.append([])
            for _ in 0..<N{
                newMaze[i].append(Cell())
            }
        }
        self.maze = newMaze
        super.init()
        fillMaze()
    }
    
    
    
    func getMaze() -> [[Cell]]{
        return maze
    }
    
    func setCell(x: Int, y: Int, itemStore: [Item], coordinateStore: [(Int,Int)]){
        maze[x][y].setItemsInRoom(itemStore: itemStore, coordinatesStore: coordinateStore)
    }
    
    func getSize() -> (Int,Int) {
        return (M,N)
    }
    
    func fillMaze() {
        fillFirstRow()
        createRightWallsAt(row: 0)
        createDownWallsAt(row: 0)
        
        for i in 1..<M {
            copyRow(row: i)
            deleteRightWallsAt(row: i)
            deleteVarietyThatHasDownWallAt(row: i)
            deleteDownWallsAt(row: i)
            fillRow(row: i)
            createRightWallsAt(row: i)
            createDownWallsAt(row: i)
        }
        
        fillLastRow()
        
        shwoMaze()
    }
    
    func fillFirstRow() {
        var varietyCounter = 1
        maze[0][0].setLeftWall(leftWall: true)
        for j in 0..<N{
            maze[0][j].setUpWall(upWall: true)
            maze[0][j].variety = varietyCounter
            varietyCounter += 1
        }
        maze[0][N-1].setRightWall(rightWall: true)
    }
    
    func fillRow(row: Int) {
        var varietyCounter = (row+1)*N
        for j in 0..<N{
            if maze[row][j].variety == 0{
                maze[row][j].variety = varietyCounter
                varietyCounter += 1
            }
        }
    }
    
    func fillLastRow() {
        for j in 0..<N-1{
            maze[M-1][j].setDownWall(downWall: true)
            if maze[M-1][j].variety != maze[M-1][j+1].variety{
                maze[M-1][j].setRightWall(rightWall: false)
                maze[M-1][j+1].setLeftWall(leftWall: false)
            }
            if maze[M-2][j].getDownWall(){
                maze[M-1][j].setUpWall(upWall: true)
            }
        }
        if maze[M-2][N-1].getDownWall(){
            maze[M-1][N-1].setUpWall(upWall: true)
        }
        maze[M-1][N-1].setDownWall(downWall: true)
    }
    
    func createRightWallsAt(row: Int) {
        var randomInt : Int
        for j in 0..<N-1{
            if maze[row][j].variety == maze[row][j+1].variety{
                maze[row][j].setRightWall(rightWall: true)
                maze[row][j+1].setLeftWall(leftWall: true)
                continue
            }
            randomInt = Int.random(in: 0...10)
            if randomInt < 7{
                maze[row][j+1].variety = maze[row][j].variety
            }else{
                maze[row][j].setRightWall(rightWall: true)
                maze[row][j+1].setLeftWall(leftWall: true)
            }
        }
    }
    
    func checkLastCellDownWall(row: Int)  {
        if maze[row][N-2] != maze[row][N-1]{
            if maze[row][N-1].getDownWall(){
                maze[row][N-1].setDownWall(downWall: false)
            }
        }
    }
    
    func searchIsolationInIdexes(startIndexOfVariety: Int, endIndexOfVariety: Int , row: Int) -> Bool {
        for i in startIndexOfVariety...endIndexOfVariety{
            if maze[row][i].getDownWall() == false{
                return true
            }
        }
        return false
    }
    
    func createDownWallsAt(row: Int) {
        var randomInt : Int
        for j in 0..<N{
            randomInt = Int.random(in: 0...10)
            if randomInt < 7{
                maze[row][j].setDownWall(downWall: true)
            }
        }
        checkingAndFixIsolatedAreasAt(row: row)
    }
    
    func checkingAndFixIsolatedAreasAt(row: Int) {
        var startIndexOfVariety = 0
        var endIndexOfVariety = 0
        var cursor = 0
        var randomInt : Int
        var check : Bool
        while cursor < N-1 {
            check = false
            while maze[row][cursor].variety == maze[row][cursor+1].variety {
                cursor += 1
                endIndexOfVariety = cursor
                if cursor >= N - 1{
                    break
                }
            }
            check = searchIsolationInIdexes(startIndexOfVariety: startIndexOfVariety,
                                            endIndexOfVariety: endIndexOfVariety, row: row)
            if !check{
                randomInt = Int.random(in: startIndexOfVariety...endIndexOfVariety)
                maze[row][randomInt].setDownWall(downWall: false)
            }
            cursor += 1
            startIndexOfVariety = cursor
            endIndexOfVariety = cursor
        }
        checkLastCellDownWall(row: row)
    }
    
    func copyRow(row: Int) {
        for j in 0..<N{
            maze[row][j] = maze[row-1][j].copy() as! Cell
        }
        for j in 0..<N{
            if !maze[row-1][j].getDownWall(){
                maze[row][j].setUpWall(upWall: false)
            }
        }
    }
    
    func deleteRightWallsAt(row: Int) {
        for j in 0..<N-1{
            maze[row][j].setRightWall(rightWall: false)
            maze[row][j+1].setLeftWall(leftWall: false)
        }
    }
    
    func deleteDownWallsAt(row: Int) {
        for j in 0..<N{
            maze[row][j].setDownWall(downWall: false)
        }
    }
    
    func deleteVarietyThatHasDownWallAt(row: Int) {
        for j in 0..<N{
            if maze[row][j].getDownWall(){
                maze[row][j].variety = 0
            }
        }
    }
    
    func shwoMaze() {
        var maz : [[String]] = []
        for i in 0..<M*3 {
            maz.append([])
            for _ in 0..<N*3{
                maz[i].append(" ")
            }
        }
        for i in 0..<M {
            for j in 0..<N{
                if maze[i][j].getDownWall(){
                    maz[i*3+2][j*3] = "#"
                    maz[i*3+2][j*3+1] = "#"
                    maz[i*3+2][j*3+2] = "#"
                }
                if maze[i][j].getUpWall(){
                    maz[i*3][j*3] = "#"
                    maz[i*3][j*3+1] = "#"
                    maz[i*3][j*3+2] = "#"
                }
                if maze[i][j].getRightWall(){
                    maz[i*3][j*3+2] = "#"
                    maz[i*3+1][j*3+2] = "#"
                    maz[i*3+2][j*3+2] = "#"
                }
                if maze[i][j].getLeftWall(){
                    maz[i*3][j*3] = "#"
                    maz[i*3+1][j*3] = "#"
                    maz[i*3+2][j*3] = "#"
                }
            }
        }
        for i in 0..<M*3{
            for j in 0..<N*3{
                print(maz[i][j], terminator:"")
            }
            print()
        }
        
    }
}
