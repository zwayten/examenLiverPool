//
//  ViewController.swift
//  examenLiverPool
//
//  Created by Yassine Zitoun on 14/11/2021.
//

import UIKit

class ViewController: UIViewController {
    //var
    let players = ["Alisson Becker", "Andy Robertson", "Fabinho Tavares", "Gini Wijnaldum","James Milner", "Joe Gomez", "Jordan Henderson", "Mohamed Salah", "Roberto Firmino", "Sadio Mane", "Trent Alexander Arnold", "Virgil Van Dijk", "Adrian"]
    
    let roles = ["GK", "LB", "CDM", "CM","CM", "CB", "CDM", "RW", "CF", "LW", "RB", "CB", "GK"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pcell")
        let contentView =  cell?.contentView
        let image = contentView?.viewWithTag(1) as! UIImageView
        let playerlbl = contentView?.viewWithTag(2) as! UILabel
        let rolelbl = contentView?.viewWithTag(3) as! UILabel
        
        image.image = UIImage(named: players[indexPath.row])
        playerlbl.text = players[indexPath.row]
        rolelbl.text = roles[indexPath.row]
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath
        performSegue(withIdentifier: "toDetail", sender: index)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail" {
            let index = sender as! IndexPath
            let destination = segue.destination as! DetailViewController
            
            destination.pl = players[index.row]
            destination.ro = roles[index.row]
        }
    }
    
    
}
