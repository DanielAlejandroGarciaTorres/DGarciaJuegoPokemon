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
            
            try! context.save()
            return true
            
        }catch let error{
            print(error.localizedDescription)
            return false
        }
    }
    
    func GetAll() -> Result{
        
        var result : Result = Result()
        
        do{
            
            let context : NSManagedObjectContext = appDelegate.persistentContainer.viewContext
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "UserName")
            
            let userScore = try context.fetch(request) as! [NSManagedObject]
            result.Objects = []
            
            for score in userScore {
                
                let getUser = UserScore(nombreUsuario: score.value(forKey: "userName") as! String,
                                        scoreUsuario: score.value(forKey: "score") as! Int)
                
                result.Objects?.append(getUser)
            }
            result.Correct = true
            
        } catch let error {
            result.Correct = false
            result.Ex = error
            result.ErrorMessage = error.localizedDescription
        }
        
        return result
    }
}
