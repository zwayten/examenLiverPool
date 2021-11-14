//
//  TopViewController.swift
//  examenLiverPool
//
//  Created by Yassine Zitoun on 14/11/2021.
//

import UIKit
import CoreData


class TopViewController: UIViewController {

    
    //
    var players = [String]()
    var notes = [Int32]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()

        // Do any additional setup after loading the view.
    }
    
    func popAlert(a: String, b: String) {
        let alert = UIAlertController(title: a, message: b, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true)
        
    }
    
    
    func fetchData() {
        //3 default
        let appDelagate = UIApplication.shared.delegate as! AppDelegate
        let persistentContainer = appDelagate.persistentContainer
        let managedContext = persistentContainer.viewContext
        
        let request = NSFetchRequest<NSManagedObject>(entityName: "Top")
        let predicate = NSPredicate(format: "note >= %d", 8)
        request.predicate = predicate
                do {
                    let result = try managedContext.fetch(request)
                    for item in result {
                        players.append(item.value(forKey: "name") as! String)
                        notes.append(item.value(forKey: "note") as! Int32)
                    }
                } catch  {
                    print("cannot fetch : error")
                }
    }
    
    func fetchMots() -> Bool {
        
        var test = false
        let appDelagate = UIApplication.shared.delegate as! AppDelegate
        let persistentContainer = appDelagate.persistentContainer
        let managedContext = persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Mots")
        
                do {
                    let result = try managedContext.fetch(request)
                    if result.count > 0 {
                        test = true
                    }
                } catch  {
                    print("cannot fetch : error")
                }
        return test
    
    }
        
    func vote(name: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let persistentContainer = appDelegate.persistentContainer
        let managedContext = persistentContainer.viewContext
        
        let entityDescription = NSEntityDescription.entity(forEntityName: "Mots", in: managedContext)
        let object = NSManagedObject.init(entity: entityDescription!, insertInto: managedContext)
        
        object.setValue(name, forKey: "name")
        
        do {
            try managedContext.save()
        } catch  {
            print("save failed")
        }
    }

}

extension TopViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return players.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bcell", for: indexPath)
        
        let contentView = cell.contentView
        
        let image = contentView.viewWithTag(1) as! UIImageView
        let noteLbl = contentView.viewWithTag(2) as! UILabel
        
        
        image.image = UIImage(named: players[indexPath.row])
        noteLbl.text = String(notes[indexPath.row])
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let test = fetchMots()
        if test == false {
            vote(name: players[indexPath.row])
            popAlert(a: "vote success", b: "you voted for \(players[indexPath.row])")
        }
        else {
            popAlert(a: "vote fail", b: "you already voted for a player")

        }
    
    
}
}
