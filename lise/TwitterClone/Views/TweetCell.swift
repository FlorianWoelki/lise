//
//  TweetCell.swift
//  lise
//
//  Created by Florian Woelki on 09.05.19.
//  Copyright © 2019 Florian Woelki. All rights reserved.
//

import UIKit

class TweetCell: UICollectionViewCell {
    
    private let topPadding: CGFloat = 24
    
    private let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .red
        iv.layer.cornerRadius = 50 / 2
        iv.clipsToBounds = true
        return iv
    }()
    
    private let profileDetailsLabel: UILabel = {
        let label = UILabel()
        
        let attributedText = NSMutableAttributedString(attributedString: NSAttributedString(string: "Fullname ", attributes: [.font: UIFont.boldSystemFont(ofSize: 16)]))
        attributedText.append(NSAttributedString(string: "@flowy • 21h", attributes: [.font: UIFont.systemFont(ofSize: 16, weight: .ultraLight)]))
        
        label.attributedText = attributedText
        
        return label
    }()
    
    private let contentTextLabel: UILabel = {
        let label = UILabel()
        label.text = "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et."
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
    
        setupLayout()
    }
    
    private func setupLayout() {
        
        // Anchor profile image view
        addSubview(profileImageView)
        profileImageView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: topPadding, left: 32, bottom: 0, right: 0))
        profileImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        // Construct full stackView
        let fullStackView = UIStackView(arrangedSubviews: [
            profileDetailsLabel, contentTextLabel
            ])
        fullStackView.spacing = 4
        fullStackView.axis = .vertical
        
        addSubview(fullStackView)
        
        fullStackView.anchor(top: topAnchor, leading: profileImageView.trailingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: topPadding, left: 16, bottom: 0, right: 24))
        
        // Construct seperator view
        let seperatorView = UIView()
        seperatorView.backgroundColor = #colorLiteral(red: 0.6688795337, green: 0.6688795337, blue: 0.6688795337, alpha: 1)
        addSubview(seperatorView)
        seperatorView.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
        seperatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
}
