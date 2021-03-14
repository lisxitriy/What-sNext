//
//  RandomChoiceViewController.swift
//  WhatNext
//
//  Created by Olga Trofimova on 28.02.2021.
//

import UIKit
import CoreData

class RandomChoiceViewController: UIViewController {
    
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var randomResultLabel: UILabel!
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var okButton: UIButton!
    
    var list: List!
    var detail: [Detail] = []
    
    let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var randomText = "Oh no...Your list is empty"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setLabelsAndButtons()
        gradient()
        
        
    }

    @IBAction func nextButtonTapped(_ sender: UIButton) {
 
        guard !detail.isEmpty else { return }
        fetchDetailData()
        let randomChoice = detail.randomElement()?.detailName
        guard let SomeRandomElement = randomChoice else { return }
        randomResultLabel.text = SomeRandomElement
        
    }
    
    @IBAction func okButtonTupped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}

extension RandomChoiceViewController {
    
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

