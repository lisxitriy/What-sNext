//
//  Extension + RandomViewController.swift
//  WhatNext
//
//  Created by Olga Trofimova on 28.02.2021.
//

import UIKit

extension RandomChoiceViewController {
    func setLabelsAndButtons() {
        mainLabel.text = "What Next?"
        mainLabel.textColor = .white
        mainLabel.font = mainLabel.font.withSize(26)
        
        randomResultLabel.text = randomText
        randomResultLabel.textColor = .white
        randomResultLabel.font = randomResultLabel.font.withSize(32)
        
        nextButton.setTitle("Next", for: .normal)
        nextButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        nextButton.titleLabel?.tintColor = .yellow
        
        okButton.setTitle("OK", for: .normal)
        okButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        okButton.titleLabel?.tintColor = .yellow
    }
    
    func gradient() {
        let color0 = UIColor(red: 167/255, green: 35/255, blue: 209/255, alpha: 1).cgColor
//        let color1 = UIColor(red: 128/255, green: 35/255, blue: 209/255, alpha: 1).cgColor
        let color2 = UIColor(red: 82/255, green: 45/255, blue: 130/255, alpha: 1).cgColor

        let gradient = CAGradientLayer()
        gradient.frame = self.view.bounds
        gradient.colors = [color0, color2]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 0, y: 1)
        self.view.layer.insertSublayer(gradient, at: 0)
    }
}
