//
//  MenuController.swift
//  DGarciaJuegoPokemon
//
//  Created by MacBookMBA3 on 16/01/23.
//

import UIKit

class MenuController: UIViewController {

    @IBOutlet var Buttons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        for button in Buttons{
            button.layer.borderWidth = 5.0
        }
        // Do any additional setup after loading the view.
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
