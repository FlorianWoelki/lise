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
    var sidebarAnimationDelay: Double = 0.5
    
    var isDarkCoverViewEnabled: Bool = false
    
    var sidebarMain: UISidebarMain! {
        didSet {
            let gesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
            addGestureRecognizer(gesture)
            
            if isDarkCoverViewEnabled {
                addSubview(darkCoverView)
                
                NSLayoutConstraint.activate([
                    darkCoverView.topAnchor.constraint(equalTo: sidebarMain.mainView.topAnchor),
                    darkCoverView.leadingAnchor.constraint(equalTo: sidebarMain.mainView.leadingAnchor),
                    darkCoverView.bottomAnchor.constraint(equalTo: sidebarMain.mainView.bottomAnchor),
                    darkCoverView.trailingAnchor.constraint(equalTo: sidebarMain.mainView.trailingAnchor)
                    ])
                
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapDismiss))
                darkCoverView.addGestureRecognizer(tapGesture)
            }
        }
    }
    
    
    // MARK: Private Variables
    private(set) var isSidebarOpened = false
    
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
        let translation = gesture.translation(in: self)
        var x = translation.x
        
        x = isSidebarOpened ? x + sidebarWidth : x
        x = min(sidebarWidth, x)
        x = max(0, x)
        
        sidebarMain.mainViewLeadingConstraint.constant = x
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
        isSidebarOpened = false
        sidebarMain.mainViewLeadingConstraint.constant = 0
        
        performAnimation()
    }
    
    private func handleOpen() {
        isSidebarOpened = true
        sidebarMain.mainViewLeadingConstraint.constant = sidebarWidth
        
        performAnimation()
    }
    
    private func performAnimation() {
        UIView.animate(withDuration: sidebarAnimationDelay, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.sidebarMain.mainController.view.layoutIfNeeded()
            self.darkCoverView.alpha = self.isSidebarOpened ? 1 : 0
        })
    }
    
}
