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
                self.saveDetailName(withTitle: newName)
                self.detailTableView.reloadData()
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
    
    //Alert for empty textField case
    private func emptyAlert() {
        let alert = UIAlertController(title: "Empty value", message: "Please, enter text", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    //Alert for empty list case
    private func emptyListAlert() {
        let alert = UIAlertController(title: "\(detailNavigationTitle) list is empty", message: "Please, fill in the list", preferredStyle: .alert)
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


extension DetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detail.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = detailTableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath)
        cell.textLabel?.text = detail[indexPath.row].detailName
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let listToDelete = detail[indexPath.row]
            detail.remove(at: indexPath.row)
            managedContext.delete(listToDelete)
            detailTableView.deleteRows(at: [indexPath], with: .fade)
        }
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
}


