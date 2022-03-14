//
//  Storyboard.swift
//  FreeNow
//
//  Created by Indubala Jayachandran on 14/03/22.
//

import UIKit

enum Storyboard: String {
    case main = "Main"
    var instance: UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
    
    func instantiateVC<T: UIViewController>(_ objectClass: T.Type) -> T {
        let storyBoard = self.instance
        return storyBoard.instantiateViewController(withIdentifier: objectClass.className) as! T
    }
}
