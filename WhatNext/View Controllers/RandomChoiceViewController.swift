//
//  RandomChoiceViewController.swift
//  WhatNext
//
//  Created by Olga Trofimova on 28.02.2021.
//

import UIKit

class RandomChoiceViewController: UIViewController {
    
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var randomResultLabel: UILabel!
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var okButton: UIButton!
    
    
    var randomText = "Oh no...Your list is empty"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setLabelsAndButtons()
        gradient()
        
        
    }

    @IBAction func nextButtonTapped(_ sender: UIButton) {
        let detail = DetailViewController()
        let rrrandom = detail.detail.randomElement()
//        print(rrrandom)
        guard let newRnd = rrrandom else { return }
        randomResultLabel.text = newRnd
//        print(randomText)
    }
    
    @IBAction func okButtonTupped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}


