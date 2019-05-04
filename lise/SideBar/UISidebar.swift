//
//  SideBar.swift
//  lise
//
//  Created by Florian Woelki on 02.05.19.
//  Copyright © 2019 Florian Woelki. All rights reserved.
//

import UIKit

class UISidebar: UIView {
    
    
    // MARK: Public Variables
    weak var delegate: SidebarDelegate?
    
    var sidebarWidth: CGFloat!
    
    var isDarkCoverViewEnabled: Bool? {
        didSet {
            guard let isDarkCoverViewEnabled = isDarkCoverViewEnabled else { return }
            
            // TODO: Implementation
        }
    }
    
    var mainViewController: UIViewController?
    var mainViewLeadingConstraint: NSLayoutConstraint? {
        didSet {
            let gesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
            addGestureRecognizer(gesture)
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
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    func openSidebar() {
        isMenuOpened = true
        
        guard let delegate = delegate else { return }
        delegate.openSidebar()
    }
    
    func closeSidebar() {
        isMenuOpened = false
        
        guard let delegate = delegate else { return }
        delegate.closeSidebar()
    }
    
    
    // MARK: Private Methods
    @objc private func handlePanGesture(gesture: UIPanGestureRecognizer) {
        guard let mainViewLeadingConstraint = mainViewLeadingConstraint else { return }
        
        let translation = gesture.translation(in: self)
        var x = translation.x
        
        x = isMenuOpened ? x + sidebarWidth : x
        x = min(sidebarWidth, x)
        x = max(0, x)
        
        mainViewLeadingConstraint.constant = x
        
        if gesture.state == .ended {
            handleEnded(gesture: gesture)
        }
    }
    
    private func handleEnded(gesture: UIPanGestureRecognizer) {
        guard let mainViewLeadingConstraint = mainViewLeadingConstraint else { return }
        
        let translation = gesture.translation(in: self)
        
        if translation.x < sidebarWidth / 2 {
            mainViewLeadingConstraint.constant = 0
            isMenuOpened = false
        } else {
            mainViewLeadingConstraint.constant = sidebarWidth
            isMenuOpened = true
        }
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            guard let mainViewController = self.mainViewController else { return }
            
            mainViewController.view.layoutIfNeeded()
        })
    }
    
    /*private func setupLayout() {
        NSLayoutConstraint.activate([
            darkCoverView.topAnchor.constraint(equalTo: topAnchor),
            darkCoverView.leadingAnchor.constraint(equalTo: leadingAnchor),
            darkCoverView.bottomAnchor.constraint(equalTo: bottomAnchor),
            darkCoverView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            ])
    }*/
    
}
