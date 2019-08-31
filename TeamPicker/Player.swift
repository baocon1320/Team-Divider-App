//
//  Player.swift
//  TeamPicker
//
//  Created by Bao Nguyen on 3/1/19.
//  Copyright © 2019 Bao Nguyen. All rights reserved.
//

import Foundation
import UIKit

class Player: NSObject, NSCoding {
    
    // Key for decode, encode
    struct PropertyKey {
        static let name = "name"
        static let position = "position"
        static let rating = "rating"
        static let image = "image"
    }
    
    var name : String
    var image : UIImage?
    var position : String
    var rating : Int
    
    //MARK: Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("players")
    
    init(name : String, image : UIImage, position : String, rating : Int) {
        self.name = name
        self.image = image
        self.position = position
        self.rating = rating
     
    }
    
    //MARK NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(image, forKey: PropertyKey.image)
        aCoder.encode(position, forKey: PropertyKey.position)
        aCoder.encode(rating, forKey: PropertyKey.rating)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObject(forKey: PropertyKey.name) as! String
        let image = aDecoder.decodeObject(forKey: PropertyKey.image) as? UIImage
        let position = aDecoder.decodeObject(forKey : PropertyKey.position) as! String
        let rating = aDecoder.decodeInteger(forKey: PropertyKey.rating)
        self.init(name: name, image: image!, position : position, rating: rating)
    }
    
    
}
