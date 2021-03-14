//
//  ViewController.swift
//  WhatNext
//
//  Created by Olga Trofimova on 26.02.2021.
//

import UIKit


class ListViewController: UIViewController {
    
    @IBOutlet weak var mainTableView: UITableView!
    
    var lists: [String] = ["dfgdfg", "dfgh"]

    override func viewDidLoad() {
        super.viewDidLoad()
       setNavigationBar()
       setView()
    }

    @IBAction func addList(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "New list", message: "Please, add new list", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Save", style: .default) { action in
            let textField = alert.textFields?.first
            
            if let newName = textField?.text, !newName.isEmpty, newName != " " {
                self.lists.append(newName)
                self.mainTableView.reloadData()
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
    

}


extension ListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = mainTableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath)
        cell.textLabel?.text = lists[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        let status = navigationItem.leftBarButtonItem?.title


          if status == "Edit" {
              mainTableView.isEditing = true
              navigationItem.leftBarButtonItem?.title = "Done"
              }
          else {
              mainTableView.isEditing = false
              navigationItem.leftBarButtonItem?.title = "Edit"
          }
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let listToDelete = lists[indexPath.row]
            lists.remove(at: indexPath.row)
            mainTableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedList = lists.remove(at: sourceIndexPath.row)
        lists.insert(movedList, at: destinationIndexPath.row)
        mainTableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = mainTableView.indexPathForSelectedRow {
            let list = lists[indexPath.row]
            
            let detailVC = segue.destination as? DetailViewController
            detailVC?.detailNavigationTitle = list
            
            
            
        }
    }
}


