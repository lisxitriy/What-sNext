//
//  Extension + DetailViewController.swift
//  WhatNext
//
//  Created by Olga Trofimova on 28.02.2021.
//

import UIKit

extension DetailViewController {
    func setNavigationBar(navigationTitle: String) {
        navigationItem.rightBarButtonItem?.title = "Add"
//        navigationItem.leftItemsSupplementBackButton = true
//        navigationItem.leftBarButtonItem = editButtonItem
        navigationItem.title = navigationTitle
    navigationController?.navigationBar.titleTextAttributes = [.font: UIFont.boldSystemFont(ofSize: 20),
            .foregroundColor: UIColor.yellow
        ]
    }
    
    func setView() {
        
        let cornerRadius: CGFloat = 10
        
        detailTableView.layer.cornerRadius = cornerRadius
        whatNextButton.layer.cornerRadius = cornerRadius
        
        whatNextButton.setTitle("What next?", for: .normal)
        whatNextButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        whatNextButton.titleLabel?.tintColor = .yellow
        
        whatNextButton.backgroundColor = #colorLiteral(red: 0.3236978054, green: 0.1063579395, blue: 0.574860394, alpha: 1)
        view.layer.backgroundColor = #colorLiteral(red: 0.9309921265, green: 0.9117598534, blue: 1, alpha: 1)
    }
}
