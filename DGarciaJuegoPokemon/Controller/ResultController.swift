//
//  ResultController.swift
//  DGarciaJuegoPokemon
//
//  Created by MacBookMBA3 on 14/02/23.
//

import UIKit
import Kingfisher

class ResultController: UIViewController {
    
    @IBOutlet weak var labelPrincipal: UILabel!
    @IBOutlet weak var Score: UILabel!
    @IBOutlet weak var correctPokemon: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!
    
    
    var userName : String? = nil
    var score : Int? = nil
    var correctString : String? = nil
    var correctAnswer : String? = nil
    
    override func viewWillAppear(_ animated: Bool) {
        let result = ScoreCoreData().AddScore(userName: userName ?? "Usurio X", score: score!)
        
        if result {
            print("Se registro el usuario correctamente.")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        
        labelPrincipal.text = "¡Perdiste \(userName!)!"
        Score.text = "Puntuación: \(score!)"
        correctPokemon.text = "Era un \(correctAnswer!.uppercased())"
        DispatchQueue.main.async {
            let url = URL(string: self.correctString!)
            self.pokemonImage.kf.setImage(with: url)
        }
        
        
        // Do any additional setup after loading the view.
    }
    

    @IBAction func PlayAgain(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func MenuPrincipal(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
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
