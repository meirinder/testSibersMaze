//
//  Alert.swift
//  TestSibersMaze
//
//  Created by Savely on 17.11.2018.
//  Copyright © 2018 Kulizhnikov. All rights reserved.
//

import UIKit

class Alert: NSObject {

    static func action(title: String, message: String, view: UIViewController){
        let ac = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
            print("OK!")
        }
        ac.addAction(okAction)
        view.present(ac, animated: true)
    }
}
