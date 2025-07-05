//
//  UserDetailCell.swift
//  GithubUsers
//
//  Created by Vikas Kumar on 02/07/25.
//

import UIKit

class UserDetailCell: UICollectionViewCell {
    
    // MARK: - Private UI Properties
    private let holderView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.background
        view.translatesAutoresizingMaskIntoConstraints = false
        view.applyRoundedCorner(of: 12)
        view.applyBorder(width: 2, color: AppColor.lightGray)
        return view
    }()
    
    private let containerStackView: UIStackView = {
        let stackView       = UIStackView()
        stackView.axis      = .horizontal
        stackView.spacing   = 10
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.applyRoundedCorner(of: 50)
        imageView.applyBorder(width: 2, color: AppColor.white)
        return imageView
    }()
    
    private let useNameLabel: UILabel = {
        let label           = UILabel()
        label.textColor     = AppColor.darkGray
        label.font          = AppFont.MainLabel
        label.textAlignment = .center
        label.numberOfLines = 2
        label.lineBreakMode = .byCharWrapping
        return label
    }()
    
    private let fullNameLabel: UILabel = {
        let label           = UILabel()
        label.textColor     = AppColor.mainLabel
        label.font          = AppFont.FullNameLabel
        label.lineBreakMode = .byCharWrapping
        return label
    }()
    
    private let followersLabel: UILabel = {
        let label       = UILabel()
        label.textColor = AppColor.mainLabel
        label.font      = AppFont.NormalLabel
        return label
    }()
    
    private let followingLabel: UILabel = {
        let label       = UILabel()
        label.textColor = AppColor.mainLabel
        label.font      = AppFont.NormalLabel
        return label
    }()
    
    private let bioLabel: UILabel = {
        let label           = UILabel()
        label.textColor     = AppColor.secondaryLabel
        label.font          = AppFont.NormalLabel
        label.numberOfLines = 6
        return label
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
        profileImageView.image = nil
    }
    
    /// Updates cell UI properties data
    /// - Parameters:
    ///   - image: Show user avatar image
    ///   - userName: Show user login name
    ///   - fullName: Show user full name
    ///   - followers: Show user followers count
    ///   - following: Show user following count
    ///   - bio: Show user bio text
    func updateCell(
        with image: String,
        userName: String,
        fullName: String,
        followers: Int,
        following: Int,
        bio: String?
    ) {
        profileImageView.loadImage(from: image)
        
        useNameLabel.text = userName
        fullNameLabel.text = fullName
        followersLabel.text = Constant.FollowersCount + "\(followers)"
        followingLabel.text = Constant.FollowingCount + "\(following)"
        
        if let bio {
            bioLabel.text = bio
            bioLabel.isHidden = false
        } else {
            bioLabel.isHidden = true
        }
    }
}

// MARK: - Private Setup UI Methods
private extension UserDetailCell {
    
    func setupUI() {
        setupHolderView()
        setupContainerStackView()
        setupImageView()
        setupLabels()
    }
    
    func setupHolderView() {
        contentView.addSubview(holderView)
        
        NSLayoutConstraint.activate([
            holderView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            holderView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            holderView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            holderView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0)
        ])
    }
    
    func setupContainerStackView() {
        holderView.addSubview(containerStackView)
        
        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalTo: holderView.topAnchor, constant: 16),
            containerStackView.bottomAnchor.constraint(equalTo: holderView.bottomAnchor, constant: -16),
            containerStackView.leadingAnchor.constraint(equalTo: holderView.leadingAnchor, constant: 10),
            containerStackView.trailingAnchor.constraint(equalTo: holderView.trailingAnchor, constant: -10)
        ])
    }
    
    func setupImageView() {
        let stackView = UIStackView(arrangedSubviews: [profileImageView, useNameLabel])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        containerStackView.addArrangedSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.widthAnchor.constraint(equalToConstant: 120),
            profileImageView.widthAnchor.constraint(equalToConstant: 100),
            profileImageView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    func setupLabels() {
        let labelStackView = UIStackView(arrangedSubviews: [fullNameLabel, bioLabel, followersLabel, followingLabel])
        labelStackView.axis = .vertical

        labelStackView.setCustomSpacing(10, after: fullNameLabel)
        labelStackView.setCustomSpacing(10, after: bioLabel)
        labelStackView.setCustomSpacing(5, after: followersLabel)

        let stackView = UIStackView(arrangedSubviews: [labelStackView])
        stackView.axis = .horizontal
        stackView.alignment = .center
        containerStackView.addArrangedSubview(stackView)
    }
}
