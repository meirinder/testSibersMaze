//
//  GameViewController.swift
//  TestSibersMaze
//
//  Created by Savely on 13.11.2018.
//  Copyright © 2018 Kulizhnikov. All rights reserved.
//

import UIKit

class GameViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    @IBOutlet weak var playView: UIView!
    
    @IBOutlet weak var useItemButton: UIButton!
    @IBOutlet weak var dropItemButton: UIButton!
    @IBOutlet weak var discardItemButton: UIButton!
    
    @IBOutlet weak var healthLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var upButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var downButton: UIButton!
    @IBOutlet weak var leftButton: UIButton!
    
    @IBOutlet weak var stepsCountLabel: UILabel!
    @IBOutlet weak var inventoryCollectionView: UICollectionView!
    
    @IBOutlet var ItemButtonsCollection: [UIButton]!
    
    var mazeBuilder = MazeShell()
    var game = Game()
    var itemButtons: [UIButton] = [UIButton]()
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        for button in ItemButtonsCollection {
            button.titleLabel?.isHidden = true
            button.addTarget(self, action: #selector(GameViewController.pressed), for: .touchUpInside)
            itemButtons.append(button)
            button.isHidden = true
        }
        
        game = Game(maze: mazeBuilder)
        game.startGame()
        
        dropItemButton.isHidden = true
        discardItemButton.isHidden = true
        useItemButton.isHidden = true
        
        healthLabel.text = "\(game.getPlayer().getHealth())"
        displayCell()
        descriptionLabel.text = ""
    }
    
    
    @objc func pressed(_ sender: UIButton) {
        if let name = sender.titleLabel?.text!{
            var number = 0
            for i in 0..<itemButtons.count {
                if sender == itemButtons[i]{
                    number = i
                }
            }
            if name != "Сундук" {
                let yItemCoordinate: Int = number / 3
                let xItemCoordinate: Int = number - (3 * yItemCoordinate)
                game.raiseItem(name: name,
                               cellCoordinate: (game.getCurrentPositionOfPlayer()),
                               itemCoordinate: (yItemCoordinate,xItemCoordinate))
                sender.isHidden = true
                inventoryCollectionView.reloadData()
                return
            }
        }
        Alert.action(title: "Information", message: "You must use the key", view: self)
    }


    @IBAction func rightStepAction(_ sender: Any) {
        if game.nextStep(direction: "Right") {
            performSegue(withIdentifier: "LoseEndGameSegue", sender: self)
        }
        for button in itemButtons {
            button.isHidden = true
        }
        displayCell()
    }

    
    @IBAction func downStepAction(_ sender: Any) {
        if game.nextStep(direction: "Down") {
            performSegue(withIdentifier: "LoseEndGameSegue", sender: self)
        }
        for button in itemButtons {
            button.isHidden = true
        }
        displayCell()
    }

    
    @IBAction func leftStepAction(_ sender: Any) {
        if game.nextStep(direction: "Left") {
            performSegue(withIdentifier: "LoseEndGameSegue", sender: self)
        }
        for button in itemButtons {
            button.isHidden = true
        }
        displayCell()
    }

    
    @IBAction func upStepAction(_ sender: Any) {
        if game.nextStep(direction: "Up"){
            performSegue(withIdentifier: "LoseEndGameSegue", sender: self)
        }
        for button in itemButtons {
            button.isHidden = true
        }
        displayCell()
    }


    @IBAction func discardItemAction(_ sender: Any) {
        if game.getPlayer().discardItem() {
            Alert.action(title: "Error",
                         message: "You must select an item",
                         view: self)
        }
        inventoryCollectionView.reloadData()
    }
    
    
    @IBAction func dropItemAction(_ sender: Any) {
        let drop = game.dropItem(index: game.getPlayer().getSelctedItemInInventory(), cellCoordinate: game.getCurrentPositionOfPlayer())
        if drop.error{
            Alert.action(title: "Error",
                         message: drop.typeOfError,
                         view: self)
        }
        inventoryCollectionView.reloadData()
        
        displayCell()
    }
    
    
    @IBAction func useItemAction(_ sender: Any) {
        let use = game.getPlayer().useItem()
        if use.successfulExecution{
            switch use.code{
            case -1:
                Alert.action(title: "Error",
                             message: "You must select an item",
                             view: self)
                break
            case -2:
                performSegue(withIdentifier: "LoseEndGameSegue", sender: self)
                break
            default:
                Alert.action(title: "Error",
                             message: "Unknown error",
                             view: self)
                break
            }
            
        }
        switch use.type {
        case "Eat":
            Alert.action(title: "\(use.code) hp",
                         message: "You ate the mushroom",
                         view: self)
            break
        case "Key":
            if game.getMazeShell().getMaze()[game.getCurrentPositionOfPlayer().y][game.getCurrentPositionOfPlayer().x].hasChest(){
                performSegue(withIdentifier: "WinEndGameSegue", sender: self)
            }
            break
        default:
            break
        }
        inventoryCollectionView.reloadData()
        displayCell()
    }






    func displayCell() {
        healthLabel.text = "\(game.getPlayer().getHealth())"
        stepsCountLabel.text = "\(game.getStepCounter())"
        descriptionLabel.text = ""
        let xCoordinate = game.getCurrentPositionOfPlayer().x
        let yCoordinate = game.getCurrentPositionOfPlayer().y
        let cell = game.getMazeShell().getMaze()[yCoordinate][xCoordinate]
        if cell.getDownWall() {
            downButton.isHidden = true
        }else{
            downButton.isHidden = false
        }
        if cell.getUpWall() {
            upButton.isHidden = true
        }else{
            upButton.isHidden = false
        }
        if cell.getRightWall() {
            rightButton.isHidden = true
        }else{
            rightButton.isHidden = false
        }
        if cell.getLeftWall() {
            leftButton.isHidden = true
        }else{
            leftButton.isHidden = false
        }
        
        let items = cell.getItemsInRoom()
        let coordinates = cell.getItemsCoordinates()
        
        for i in 0..<items.count {
            fillButton(title: items[i].name,
                       coordinates: coordinates[i],
                       image: items[i].image)
        }
    }

    
    func fillButton(title: String, coordinates: (y: Int, x: Int), image: UIImage) {
        let index = game.numberOfItemsPerLineOrColumn * coordinates.y + coordinates.x
        itemButtons[index].setBackgroundImage(image, for: .normal)
        itemButtons[index].titleLabel?.isHidden = true
        itemButtons[index].setTitle(title, for: .normal)
        itemButtons[index].isHidden = false
    }
    

    // MARK: release Delegate and Datasource
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  game.getPlayer().getInventory().getItemStore().count
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = inventoryCollectionView.dequeueReusableCell(withReuseIdentifier: "itemCell", for: indexPath) as! InventoryCollectionViewCell
        cell.itemNameLabel.text = game.getPlayer().getInventory().getItemStore()[indexPath.item].name
        cell.itemImageView.image = game.getPlayer().getInventory().getItemStore()[indexPath.item].image
        cell.layer.borderWidth = 2
        cell.layer.borderColor = UIColor.gray.cgColor
        return cell
    }

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let currentCell = indexPath.item
        game.getPlayer().setSelctedItemInInventory(index: currentCell)
        let item = game.getPlayer().getInventory().getItemStore()[currentCell]
        if ((item is EatableItem) || (item is Key)) {
            useItemButton.isHidden = false
        }else {
            useItemButton.isHidden = true
        }
        dropItemButton.isHidden = false
        discardItemButton.isHidden = false
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderWidth = 2
        cell?.layer.borderColor = UIColor.green.cgColor
        collectionView.allowsMultipleSelection = false
        descriptionLabel.text = item.specification
    }


    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        dropItemButton.isHidden = false
        discardItemButton.isHidden = false
        useItemButton.isHidden = true
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderWidth = 2
        cell?.layer.borderColor = UIColor.gray.cgColor
    }
}
