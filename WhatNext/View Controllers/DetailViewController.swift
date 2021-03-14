//
//  DetailViewController.swift
//  WhatNext
//
//  Created by Olga Trofimova on 28.02.2021.
//

import UIKit

class DetailViewController: UIViewController {
    
    var detail: [String] = []

    
    @IBOutlet weak var detailTableView: UITableView!
    @IBOutlet weak var whatNextButton: UIButton!
    
    var detailNavigationTitle = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setNavigationBar(navigationTitle: detailNavigationTitle)
        setView()

        // Do any additional setup after loading the view.
    }
    
    
    //MARK: - Alerts
    
    @IBAction func addItem(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "New item", message: "Please, add new item", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Save", style: .default) { action in
            let textField = alert.textFields?.first
            
            if let newName = textField?.text, !newName.isEmpty, newName != " " {
                self.detail.append(newName)
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
//        if detail.isEmpty {
//            emptyListAlert()
//        }
    }
    
  
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
  
     guard segue.identifier == "toRandomChoice" else {return}
              let rnd = segue.destination as? RandomChoiceViewController
              let destination = detail.randomElement()
              guard let rndDestination = destination else { return }
                  rnd?.randomText = rndDestination
 
    }
 

}

extension DetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detail.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = detailTableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath)
        cell.textLabel?.text = detail[indexPath.row]
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
            detailTableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}


