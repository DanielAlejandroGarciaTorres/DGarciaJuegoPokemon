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
    lazy var userName : String = ""
    
    var pokemons : [PokemonModel] = []
    var randomButtonPokemon : [PokemonModel] = [] {
        didSet {
            SetButtonTitle()
        }
    }
    var correctAnswer : String = ""
    var correctAnwserImage : String = ""
    
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
            self.correctAnwserImage = (pokemonImage.Object as! ImageModel).imageURL

            DispatchQueue.main.async {
                let url = URL(string: self.correctAnwserImage)
                let blackImage = ColorControlsProcessor(brightness: -1, contrast: 1, saturation: 1, inputEV: 0)
                self.PokemonImage.kf.setImage(with: url, options: [.processor(blackImage)])
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
            print(correctAnwserImage)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                let url  = URL(string : self.correctAnwserImage)
                self.PokemonImage.kf.setImage(with: url)
            }
        
            
            Timer.scheduledTimer(withTimeInterval: 0.8, repeats: false){ timer in
                self.didUpdatePokemon()
                self.LabelMessage.text = " "
                sender.layer.borderWidth = 0
            }
            
        } else {
            LabelMessage.text = "No, no es un \(correctAnswer.capitalized)"
            sender.layer.borderWidth = 4
            sender.layer.borderColor = UIColor.systemRed.cgColor
            
            let alert = UIAlertController(title: "Perdiste", message: "Ingresa tu User name", preferredStyle: .alert)
            
            alert.addTextField { textfield in
                textfield.placeholder = "Nombre de usuario"
            }
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
                let textfield = alert?.textFields![0]
                self.userName = textfield!.text!
                
                self.performSegue(withIdentifier: "goToResults", sender: self)
                sender.layer.borderWidth = 0
            }))
                                          
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResults" {
            let resultController = segue.destination as! ResultController
            resultController.userName = self.userName
            resultController.score = gameViewModel.GetScore()
            resultController.correctString = self.correctAnwserImage
            resultController.correctAnswer = self.correctAnswer
            
            self.resetGame()

        }
    }
   
    func resetGame() {
        self.didUpdatePokemon()
        gameViewModel.SetScore(score: 0)
        ScoreLabel.text = "Puntaje: \(gameViewModel.GetScore())"
        LabelMessage.text = " "
        
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
