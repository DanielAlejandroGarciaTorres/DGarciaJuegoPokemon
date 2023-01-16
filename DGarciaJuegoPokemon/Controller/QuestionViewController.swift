//
//  QuizViewController.swift
//  DGarciaJuegoPokemon
//
//  Created by MacBookMBA3 on 13/01/23.
//

import UIKit

class QuestionViewController: UIViewController {

    @IBOutlet weak var ScoreLabel: UILabel!
    @IBOutlet weak var pokemonDarkImage: UIImageView!
    @IBOutlet var AnswerButtons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
            
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func SelectedButton(_ sender: UIButton) {
        print("hola")
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
