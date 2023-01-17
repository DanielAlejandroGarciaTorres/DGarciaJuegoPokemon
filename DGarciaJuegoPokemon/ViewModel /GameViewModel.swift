//
//  GameViewModel.swift
//  DGarciaJuegoPokemon
//
//  Created by MacBookMBA3 on 17/01/23.
//

import Foundation

class GameViewModel {
    var gameModel = GameModel()
    
    func checkAnswer( userAnswer : String, correctAnswer: String) -> Bool {
        if userAnswer.lowercased() == correctAnswer.lowercased() {
            self.gameModel.score += 10
            return true
        }
        return false
    }
    
    func GetScore() -> Int {
        return self.gameModel.score
    }
    
    func SetScore(score : Int) {
        self.gameModel.score = score
    }
    
}
