//
//  ListViewController + TableViewController.swift
//  WhatNext
//
//  Created by Olga Trofimova on 14.03.2021.
//

import UIKit

extension ListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = mainTableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath)
        cell.textLabel?.text = lists[indexPath.row].name
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
            managedContext.delete(listToDelete)
            mainTableView.deleteRows(at: [indexPath], with: .fade)
            
            do {
                try managedContext.save()
            } catch let error as NSError {
                print(error.localizedDescription)
            }
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
        let someList = lists[indexPath.row]
        performSegue(withIdentifier: "toDetailList", sender: someList)
    }
}
