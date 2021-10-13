//
//  ColorTableViewCell.swift
//  CustomTransitionsAgoraVai
//
//  Created by Leonardo on 11/10/2021.
//

import UIKit

class ColorTableViewCell: UITableViewCell {

    let emojiImageView = UIImageView()
    let titleLabel = UILabel()
    static let reuseId = "ColorTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureContentView()
        configureImageView()
        configureTitleLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureContentView() {
        contentView.backgroundColor = .white
    }
    
    private func configureImageView() {
        emojiImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(emojiImageView)
        
        emojiImageView.contentMode = .scaleAspectFit
        
        NSLayoutConstraint.activate([
            emojiImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            emojiImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            emojiImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            emojiImageView.heightAnchor.constraint(equalToConstant: 44),
            emojiImageView.widthAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    private func configureTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)
        titleLabel.textColor = .systemBlue
        titleLabel.numberOfLines = 2
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: emojiImageView.trailingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            titleLabel.centerYAnchor.constraint(equalTo: emojiImageView.centerYAnchor)
        ])
    }
    
    func configure(imageString: String) {
        emojiImageView.image = UIImage(systemName: imageString)
        titleLabel.text = imageString
    }

}
