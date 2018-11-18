//
//  StartViewController.swift
//  TestSibersMaze
//
//  Created by Savely on 13.11.2018.
//  Copyright © 2018 Kulizhnikov. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {
    
    @IBOutlet weak var columnCounterTextField: UITextField!
    @IBOutlet weak var rowCounterTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "StartGameSegue" {
            let desVC = segue.destination as! GameViewController
            desVC.mazeBuilder  = MazeShell(M: Int(columnCounterTextField.text!)!,
                                           N: Int(rowCounterTextField.text!)!)
        }
    }
    
    
    @IBAction func startGameAction(_ sender: Any) {
        if (columnCounterTextField.text?.isEmpty)! {
            Alert.action(title: "Error",
                         message: "Enter column quantity",
                         view: self)
        } else if (rowCounterTextField.text?.isEmpty)! {
            Alert.action(title: "Error",
                         message: "Enter row quantity",
                         view: self)
        } else if columnCounterTextField.text == "1" || columnCounterTextField.text == "0"{
            Alert.action(title: "Error",
                         message: "Too few columns ",
                         view: self)
        }else if rowCounterTextField.text == "1" || rowCounterTextField.text == "0"{
            Alert.action(title: "Error",
                         message: "Too few rows",
                         view: self)
        }else{
            performSegue(withIdentifier: "StartGameSegue", sender: self)
        }
    }
}
