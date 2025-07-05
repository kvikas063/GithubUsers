//
//  UserListCell.swift
//  GithubUsers
//
//  Created by Vikas Kumar on 01/07/25.
//

import UIKit

class UserListCell: UICollectionViewCell {

    // MARK: - Private UI Properties
    private let holderView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.background
        view.translatesAutoresizingMaskIntoConstraints = false
        view.applyRoundedCorner(of: 12)
        view.applyBorder(width: 2, color: AppColor.lightGray)
        return view
    }()
    
    private let nameLabel: UILabel = {
        let label           = UILabel()
        label.textColor     = AppColor.mainLabel
        label.font          = AppFont.MainLabel
        label.textAlignment = .center
        label.numberOfLines = 2
        label.lineBreakMode = .byCharWrapping
        return label
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.applyRoundedCorner(of: 50)
        imageView.applyBorder(width: 2, color: AppColor.white)
        return imageView
    }()
    
    // MARK: - Cell Init Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    /// Updates cell UI properties data
    /// - Parameters:
    ///   - image: Show user avatar image
    ///   - name: Show user login name
    func updateCell(with image: String, and name: String) {
        nameLabel.text = name
        imageView.loadImage(from: image)
    }
}

// MARK: - Private Setup UI Methods
private extension UserListCell {
    
     func setupUI() {
        setupHolderView()
        setupSubviews()
    }
    
    func setupHolderView() {
        addSubview(holderView)
        
        NSLayoutConstraint.activate([
            holderView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            holderView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            holderView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            holderView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0)
        ])
    }
    
    func setupSubviews() {
        let stackView = UIStackView(arrangedSubviews: [imageView, nameLabel])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        holderView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: holderView.topAnchor, constant: 10),
            stackView.bottomAnchor.constraint(equalTo: holderView.bottomAnchor, constant: -10),
            stackView.leadingAnchor.constraint(equalTo: holderView.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: holderView.trailingAnchor, constant: -10),
            
            imageView.widthAnchor.constraint(equalToConstant: 100),
            imageView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
}
