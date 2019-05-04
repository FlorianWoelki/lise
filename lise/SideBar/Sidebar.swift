//
//  SideBar.swift
//  lise
//
//  Created by Florian Woelki on 02.05.19.
//  Copyright © 2019 Florian Woelki. All rights reserved.
//

import UIKit

class Sidebar: UIViewController {
    
    
    // MARK: Public Variables
    weak var delegate: SidebarDelegate?
    
    var menuWidth: CGFloat = 300
    
    var isDarkCoverViewEnabled: Bool? {
        didSet {
            guard let isDarkCoverViewEnabled = isDarkCoverViewEnabled else { return }
            
            // TODO: Implementation
        }
    }
    
    
    // MARK: Private Variables
    private(set) var isMenuOpened = false
    
    private let darkCoverView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.7)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alpha = 0
        return view
    }()
    
    
    // MARK: Public Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupLayout()
    }
    
    func openSidebar() {
        isMenuOpened = true
        setNeedsStatusBarAppearanceUpdate()
        
        guard let delegate = delegate else { return }
        delegate.openSidebar()
    }
    
    func closeSidebar() {
        isMenuOpened = false
        setNeedsStatusBarAppearanceUpdate()
        
        guard let delegate = delegate else { return }
        delegate.closeSidebar()
    }
    
    
    // MARK: Private Methods
    private func setupLayout() {
        NSLayoutConstraint.activate([
            darkCoverView.topAnchor.constraint(equalTo: view.topAnchor),
            darkCoverView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            darkCoverView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            darkCoverView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            ])
    }
    
}
