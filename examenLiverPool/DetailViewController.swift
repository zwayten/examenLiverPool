//
//  DetailViewController.swift
//  examenLiverPool
//
//  Created by Yassine Zitoun on 14/11/2021.
//

import UIKit
import CoreData

class DetailViewController: UIViewController {

    var pl: String?
    var ro: String?
    
    var rate = 0
    
    @IBOutlet var imageview: UIImageView!
    @IBOutlet var pName: UILabel!
    @IBOutlet var pRate: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageview.image = UIImage(named: pl!)
        pName.text = pl!
        pRate.text = String(rate)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func rateSlide(_ sender: UISlider) {
        rate = Int(sender.value)
        pRate.text = String(rate)
    }
    
    func popAlert(a: String, b: String) {
        let alert = UIAlertController(title: a, message: b, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true)
        
    }
    
    @IBAction func saveBtn(_ sender: UIBarButtonItem) {
        let exist = checkPlayer(name: pl!)
        if exist == false {
            savePlayer()
            popAlert(a: "Message", b: "Player added")
        }
        else {
            popAlert(a: "Message", b: "Player already exist")
        }
        
    }
    
    
    func savePlayer() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let persistentContainer = appDelegate.persistentContainer
        let managedContext = persistentContainer.viewContext
        
        let entityDescription = NSEntityDescription.entity(forEntityName: "Top", in: managedContext)
        let object = NSManagedObject.init(entity: entityDescription!, insertInto: managedContext)
        
        object.setValue(pl!, forKey: "name")
        object.setValue(rate, forKey: "note")
        
        do {
            try managedContext.save()
        } catch  {
            print("save failed")
        }
        
        
    }
    
    func checkPlayer(name: String) -> Bool {
        var exist = false
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let persistentContainer = appDelegate.persistentContainer
        let managedContext = persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Top")
        let predicate = NSPredicate(format: "name = %@", name)
        request.predicate = predicate
        
        do {
            let result = try managedContext.fetch(request)
            if result.count > 0 {
                exist = true
            }
                
        } catch  {
            print("error")
        }
        
        return exist
        
    }

}
