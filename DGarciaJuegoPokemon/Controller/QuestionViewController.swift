//
//  QuizViewController.swift
//  DGarciaJuegoPokemon
//
//  Created by MacBookMBA3 on 13/01/23.
//

import UIKit
import Kingfisher

class QuestionViewController: UIViewController {

    @IBOutlet weak var ScoreLabel: UILabel!
    @IBOutlet weak var pokemonDarkImage: UIImageView!
    @IBOutlet var AnswerButtons: [UIButton]!
    @IBOutlet weak var LabelMessage: UILabel!
    @IBOutlet weak var PokemonImage: UIImageView!
    
    lazy var pokemonManager = PokemonManager()
    lazy var imageManager = ImageManager()
    lazy var gameViewModel = GameViewModel()
    
    var pokemons : [PokemonModel] = []
    var randomButtonPokemon : [PokemonModel] = [] {
        didSet {
            SetButtonTitle()
        }
    }
    var correctAnswer : String = ""
    var corrctAnserImage : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LabelMessage.text = ""
        pokemonManager.fetchPokemon {data in
            
            if data.Correct {
                self.pokemons = data.Objects! as! [PokemonModel]
            }
            self.didUpdatePokemon()
        }
        
        
        // Do any additional setup after loading the view.
    }
    
    func didUpdatePokemon(){
        randomButtonPokemon = pokemons.Choose(4)
        let index = Int.random(in: 0...3)
        let imageData = randomButtonPokemon[index].imageUrl
        correctAnswer = randomButtonPokemon[index].name
        
        imageManager.fetchImagePokemon(imageUrl: imageData) {pokemonImage in
//            print(self.correctAnswer)
//            print((pokemonImage.Object as! ImageModel).imageURL)
            self.corrctAnserImage = (pokemonImage.Object as! ImageModel).imageURL
            
            DispatchQueue.main.async {
                let url = URL(string: self.corrctAnserImage)
                self.PokemonImage.image = UIImage(
            }
            
        }
    }
    
    
    @IBAction func SelectedButton(_ sender: UIButton) {
        let userAnswer = sender.currentTitle!
        if gameViewModel.checkAnswer(userAnswer: userAnswer, correctAnswer: correctAnswer) {
            LabelMessage.text = "Sí, es un \(correctAnswer.capitalized)"
            ScoreLabel.text = "Puntaje: \(gameViewModel.GetScore())"
            sender.layer.borderWidth = 4
            sender.layer.borderColor = UIColor.systemGreen.cgColor
        }
    }
    
    func SetButtonTitle() {
        for (index, button) in AnswerButtons.enumerated() {
            DispatchQueue.main.async {
                button.setTitle(self.randomButtonPokemon[safe: index]?.name.capitalized, for: .normal)
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension Collection where Indices.Iterator.Element == Index {
    
    public subscript(safe index: Index) -> Iterator.Element? {
        return  (startIndex <= index && index < endIndex) ? self[index] : nil
    }
}

extension Collection {
    func Choose(_ numero : Int) -> Array<Element> {
        Array(shuffled().prefix(numero))
    }
}
