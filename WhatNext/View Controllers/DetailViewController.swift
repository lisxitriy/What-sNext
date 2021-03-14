//
//  DetailViewController.swift
//  WhatNext
//
//  Created by Olga Trofimova on 28.02.2021.
//

import UIKit
import CoreData

class DetailViewController: UIViewController {
        
    @IBOutlet weak var detailTableView: UITableView!
    @IBOutlet weak var whatNextButton: UIButton!
    
    var detail: [Detail] = []
    var list: List!
    
    let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var detailNavigationTitle = ""
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        fetchDetailData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBar(navigationTitle: detailNavigationTitle)
        setView()
      
    }
    
    
    //MARK: - Alerts
    
    @IBAction func addItem(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "New item", message: "Please, add new item", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Save", style: .default) { action in
            let textField = alert.textFields?.first
            
            if let newName = textField?.text, !newName.isEmpty, newName != " " {
                
                for newName in self.detail {
                    if self.detail.contains(newName) {
                        self.sameValue()
                        print(self.detail)
                    } else {
                        self.saveDetailName(withTitle: "\(newName)")
                        self.detailTableView.reloadData()
                    }
                }
            } else {
                self.emptyAlert()
            }
        }
        
        alert.addTextField { _ in }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
        
    }
    
    //Предупреждение, если поле пустое
    private func emptyAlert() {
        let alert = UIAlertController(title: "Empty value", message: "Please, enter text", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    //Предупреждение, если такое же имя уже есть в таблице
    private func sameValue() {
        let alert = UIAlertController(title: "Same name", message: "Such a name already exists. Please, enter a new name", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    
    // MARK: - Navigation
    
    @IBAction func whatNextButton(_ sender: UIButton) {

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
  
     guard segue.identifier == "toRandomChoice" else {return}
        guard let random = segue.destination as? RandomChoiceViewController else { return }
        let destination = detail.randomElement()?.detailName
        guard let randomDestination = destination else { return }
        random.randomText = randomDestination
        random.list = list
        random.detail = detail
 
    }
}

//MARK: - Core Data
    
extension DetailViewController {
    
    func saveDetailName(withTitle name: String) {
        guard let entity = NSEntityDescription.entity(forEntityName: "Detail", in: managedContext) else { return }
        let listObject = Detail(entity: entity, insertInto: managedContext)
        listObject.detailName = name
        listObject.list = list
        
        do {
            try managedContext.save()
            detail.append(listObject)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
    }
    
    func fetchDetailData() {
        
        let predicate = NSPredicate(format: "list.name == %@", list.name!)
        let fetchRequest = NSFetchRequest<Detail>(entityName: "Detail")
        fetchRequest.predicate = predicate
        
        do {
            detail = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
 
}





