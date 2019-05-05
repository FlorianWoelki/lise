//
//  ViewController.swift
//  lise
//
//  Created by Florian Woelki on 01.05.19.
//  Copyright © 2019 Florian Woelki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private let redView: UIView = {
        let v = UIView()
        v.backgroundColor = .red
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    private let blueView: UIView = {
        let v = UIView()
        v.backgroundColor = .blue
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    private lazy var sidebar: UISidebar = {
        let sidebar = UISidebar()
        sidebar.sidebarWidth = 300
        sidebar.translatesAutoresizingMaskIntoConstraints = false
        return sidebar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
    
        setupLayout()
    }
    
    var redViewLeadingConstraint: NSLayoutConstraint!
    
    private func setupLayout() {
        view.addSubview(redView)
        view.addSubview(blueView)
        view.addSubview(sidebar)
        
        NSLayoutConstraint.activate([
            sidebar.topAnchor.constraint(equalTo: view.topAnchor),
            sidebar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            sidebar.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            sidebar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            redView.topAnchor.constraint(equalTo: view.topAnchor),
            redView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            redView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            blueView.topAnchor.constraint(equalTo: view.topAnchor),
            blueView.trailingAnchor.constraint(equalTo: redView.safeAreaLayoutGuide.leadingAnchor),
            blueView.widthAnchor.constraint(equalToConstant: sidebar.sidebarWidth),
            blueView.bottomAnchor.constraint(equalTo: redView.bottomAnchor),
            ])
        
        redViewLeadingConstraint = redView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        redViewLeadingConstraint.isActive = true
        
        sidebar.mainController = self
        sidebar.mainView = redView
        sidebar.mainViewLeadingConstraint = redViewLeadingConstraint
    }

}

