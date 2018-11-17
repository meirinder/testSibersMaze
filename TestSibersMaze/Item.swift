//
//  Item.swift
//  TestSibersMaze
//
//  Created by Savely on 14.11.2018.
//  Copyright © 2018 Kulizhnikov. All rights reserved.
//

import UIKit

class Item: NSObject{
    
    let name: String
    let descript: String
    let image: UIImage
    
    init(name: String, descript: String) {
        self.name = name
        self.descript = descript
        switch name {
        case "Сундук":
            image = UIImage(named: "chest.png")!
            break
        case "Ключ":
            image = UIImage(named: "key.png")!
            break
        case "Кость":
            image = UIImage(named: "bone.png")!
            break
        case "Камень":
            image = UIImage(named: "stone.png")!
            break
        case "Гриб":
            image = UIImage(named: "mushroom.png")!
            break
        default:
            image = UIImage()
            break
        }
    }
    
    
    
}

extension Item: NSCopying{
    func copy(with zone: NSZone? = nil) -> Any {
        let copy = Item(name: name, descript: descript)
        return copy
    }
}
