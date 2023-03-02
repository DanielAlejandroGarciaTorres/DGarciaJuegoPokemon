//
//  UserViewModel.swift
//  DGarciaJuegoPokemon
//
//  Created by MacBookMBA3 on 02/03/23.
//

import Foundation
import CoreData
import UIKit

class UserViewModel {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    func GetAll() -> Result {
        
        var result : Result = Result()
        
        do {
            
            let context : NSManagedObjectContext = appDelegate.persistentContainer.viewContext
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "UserName")
            
            let userName = try context.fetch(request) as! [NSManagedObject]
            
            result.Objects = []
            
            for user in userName {
                
                let 
               
                let productoId = ProductoViewModel().GetById(idProducto: producto.value(forKey: "idProducto") as! Int).Object as! Producto
                
                let productoRecupera = VentaProducto(
                                    idVentaProducto: Int(producto.objectID.uriRepresentation().absoluteString.components(separatedBy: "/p")[1])!,
                                    producto: productoId,
                                    cantidad: producto.value(forKey: "cantidad") as! Int)
                
                result.Objects?.append(productoRecupera)
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
