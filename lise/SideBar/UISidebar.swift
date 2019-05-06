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
    weak var delegate: UISidebarDelegate?
    
    var sidebarWidth: CGFloat!
    
    var isDarkCoverViewEnabled: Bool? {
        didSet {
            guard let isDarkCoverViewEnabled = isDarkCoverViewEnabled else { return }
            
            // TODO: Implementation
        }
    }
    
    var mainView: UIView! {
        didSet {
            addSubview(darkCoverView)
            
            NSLayoutConstraint.activate([
                darkCoverView.topAnchor.constraint(equalTo: mainView.topAnchor),
                darkCoverView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
                darkCoverView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor),
                darkCoverView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor)
                ])
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapDismiss))
            darkCoverView.addGestureRecognizer(tapGesture)
        }
    }
    var mainController: UIViewController!
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
        handleOpen()
        
        guard let delegate = delegate else { return }
        delegate.openSidebar()
    }
    
    func closeSidebar() {
        handleClose()
        
        guard let delegate = delegate else { return }
        delegate.closeSidebar()
    }
    
    
    // MARK: Private Methods
    @objc private func handleTapDismiss() {
        closeSidebar()
    }
    
    @objc private func handlePanGesture(gesture: UIPanGestureRecognizer) {
        guard let mainViewLeadingConstraint = mainViewLeadingConstraint else { return }
        
        let translation = gesture.translation(in: self)
        var x = translation.x
        
        x = isMenuOpened ? x + sidebarWidth : x
        x = min(sidebarWidth, x)
        x = max(0, x)
        
        mainViewLeadingConstraint.constant = x
        darkCoverView.alpha = x / sidebarWidth
        
        if gesture.state == .ended {
            handleEnded(gesture: gesture)
        }
    }
    
    private func handleEnded(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: self)
        
        if translation.x < sidebarWidth / 2 {
            handleClose()
        } else {
            handleOpen()
        }
    }
    
    private func handleClose() {
        guard let mainViewLeadingConstraint = mainViewLeadingConstraint else { return }
        
        isMenuOpened = false
        mainViewLeadingConstraint.constant = 0
        
        performAnimation()
    }
    
    private func handleOpen() {
        guard let mainViewLeadingConstraint = mainViewLeadingConstraint else { return }
        
        isMenuOpened = true
        mainViewLeadingConstraint.constant = sidebarWidth
        
        performAnimation()
    }
    
    private func performAnimation() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            guard let mainController = self.mainController else { return }
            
            mainController.view.layoutIfNeeded()
            self.darkCoverView.alpha = self.isMenuOpened ? 1 : 0
        })
    }
    
}
