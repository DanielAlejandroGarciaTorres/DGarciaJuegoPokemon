//
//  ScoresController.swift
//  DGarciaJuegoPokemon
//
//  Created by MacBookMBA3 on 02/03/23.
//

import UIKit

class ScoresController: UIViewController {
    
    @IBOutlet weak var scoreTable: UITableView!
    
    var usersScore = [UserScore]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scoreTable.delegate = self
        scoreTable.dataSource = self
        scoreTable.register(UINib(nibName: "UserTableViewCell", bundle: nil), forCellReuseIdentifier: "ScoreCell")
        LoadData()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    func LoadData() {
        let result = ScoreCoreData().GetAll()
        
        if result.Correct {
            usersScore = result.Objects! as! [UserScore]
            print(usersScore)
            usersScore = usersScore.sorted {$0.scoreUsuario > $1.scoreUsuario}
            print(usersScore)
            scoreTable.reloadData()
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

extension ScoresController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersScore.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = scoreTable.dequeueReusableCell(withIdentifier: "ScoreCell", for: indexPath) as! UserTableViewCell
        
        cell.userName.text = usersScore[indexPath.row].nombreUsuario
        cell.score.text = "Score: \(usersScore[indexPath.row].scoreUsuario)"
        cell.position.text = "\(indexPath.row + 1)°"
        
        return cell
    }
    
    
}
