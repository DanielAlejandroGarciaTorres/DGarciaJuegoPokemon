//
//  ImageManager.swift
//  DGarciaJuegoPokemon
//
//  Created by MacBookMBA3 on 17/01/23.
//

import Foundation

struct ImageManager {
    
    func fetchImagePokemon(imageUrl : String ,pokemonCompletionHandler : @escaping (Result) -> Void) {
        var result = Result()
        if let url = URL(string: imageUrl) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    result.Correct = false
                    result.ErrorMessage = error!.localizedDescription
                    result.Ex = error
                }
                
                if let safeData = data {
                    if let imagePokemon = self.parseJSON(imageData: safeData){
                        result.Object = imagePokemon
                        result.Correct = true
                    }
                }
                pokemonCompletionHandler(result)
            }
            task.resume()
        }
    }
        
    func parseJSON(imageData: Data) -> ImageModel? {
        let decoder = JSONDecoder()
        
        do{
            let decodeData = try decoder.decode(ImageData.self, from: imageData)
            let image = decodeData.sprites.other?.officialArtwork.frontDefault ?? ""
            return ImageModel(imageURL: image)
        } catch {
            return nil
        }
    }
}
