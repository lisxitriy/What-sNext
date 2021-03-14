//
//  Extension + ListViewController.swift
//  WhatNext
//
//  Created by Olga Trofimova on 28.02.2021.
//

import UIKit

extension ListViewController {
    func setNavigationBar() {
        navigationItem.leftBarButtonItem = editButtonItem
        navigationItem.rightBarButtonItem?.title = "Add"
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.3236978054, green: 0.1063579395, blue: 0.574860394, alpha: 1)
        navigationController?.navigationBar.tintColor = .white
        navigationItem.title = "Lists"
    navigationController?.navigationBar.titleTextAttributes = [.font: UIFont.boldSystemFont(ofSize: 20),
            .foregroundColor: UIColor.yellow
        ]
    }
    
    func setView() {
        let cornerRadius: CGFloat = 10
        mainTableView.layer.cornerRadius = cornerRadius
        view.layer.backgroundColor = #colorLiteral(red: 0.9309921265, green: 0.9117598534, blue: 1, alpha: 1)
    }
}
