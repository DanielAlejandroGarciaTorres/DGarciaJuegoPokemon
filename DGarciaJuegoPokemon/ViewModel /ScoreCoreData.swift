//
//  ScoreCoreData.swift
//  DGarciaJuegoPokemon
//
//  Created by MacBookMBA3 on 15/02/23.
//

import Foundation
import CoreData
import UIKit

class ScoreCoreData {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    func AddScore( userName : String, score : Int) -> Bool {
       
        do {
            
            let context = appDelegate.persistentContainer.viewContext
            let entidad = NSEntityDescription.entity(forEntityName: "UserName", in: context)
            let userGameCoreData = NSManagedObject(entity: entidad!, insertInto: context)
            
            userGameCoreData.setValue(userName, forKey: "userName")
            userGameCoreData.setValue(score, forKey: "score")
            
        }catch let error{
            print(error.localizedDescription)
            return false
        }
        return true
    }
    
    
}
