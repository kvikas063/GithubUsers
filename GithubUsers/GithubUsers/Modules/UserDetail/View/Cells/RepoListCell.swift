//
//  RepoListCell.swift
//  GithubUsers
//
//  Created by Vikas Kumar on 02/07/25.
//

import UIKit

class RepoListCell: UICollectionViewCell {
    
    // MARK: - Private UI Properties
    private let holderView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.background
        view.translatesAutoresizingMaskIntoConstraints = false
        view.applyRoundedCorner(of: 12)
        view.applyBorder(width: 1, color: AppColor.lightGray)
        return view
    }()
    
    private let repoNameLabel: UILabel = {
        let label           = UILabel()
        label.textColor     = AppColor.mainLabel
        label.font          = AppFont.MainLabel
        label.numberOfLines = 2
        return label
    }()
    
    private let languageLabel: UILabel = {
        let label       = UILabel()
        label.textColor = AppColor.mainLabel
        label.font      = AppFont.MainLabel
        return label
    }()
    
    private let starsLabel: UILabel = {
        let label       = UILabel()
        label.textColor = AppColor.mainLabel
        label.font      = AppFont.MainLabel
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label           = UILabel()
        label.textColor     = AppColor.mainLabel
        label.font          = AppFont.MainLabel
        label.numberOfLines = 5
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
    
    /// Updates cell UI properties data
    /// - Parameters:
    ///   - repo: User repository title
    ///   - language: User repository language used
    ///   - stars: User repository stars count
    ///   - description: User repository description text
    func updateCell(
        with repo: String,
        language: String?,
        stars: Int,
        description: String?
    ) {
        repoNameLabel.text = repo
        languageLabel.text = (language ?? "N/A").capitalized
        starsLabel.text = "\(stars)"
        if let description {
            descriptionLabel.isHidden = false
            descriptionLabel.text = description
        } else {
            descriptionLabel.isHidden = true
        }
    }
}

// MARK: - Private Setup UI Methods
private extension RepoListCell {
    
    func setupUI() {
        setupHolderView()
        setupSubviews()
    }
    
    func setupHolderView() {
        contentView.addSubview(holderView)
        
        NSLayoutConstraint.activate([
            holderView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            holderView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            holderView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            holderView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0)
        ])
    }
    
    func setupSubviews() {
        let repoTitleLabel = createLabel(with: Constant.RepositoryName)
        let repoStackView = createStackView(leftLabel: repoTitleLabel, rightLabel: repoNameLabel)
        
        let languageTitleLabel = createLabel(with: Constant.Languages)
        let languageStackView = createStackView(leftLabel: languageTitleLabel, rightLabel: languageLabel)

        let starsTitleLabel = createLabel(with: Constant.StarsCount)
        let starsStackView = createStackView(leftLabel: starsTitleLabel, rightLabel: starsLabel)
        
        let labelStackView = UIStackView(arrangedSubviews: [repoStackView,
                                                            languageStackView,
                                                            starsStackView,
                                                            descriptionLabel])
        labelStackView.axis = .vertical
        labelStackView.spacing = 8
        labelStackView.setCustomSpacing(12, after: starsStackView)
        
        let stackView = UIStackView(arrangedSubviews: [labelStackView])
        stackView.axis = .horizontal
        stackView.alignment = .top
        stackView.translatesAutoresizingMaskIntoConstraints = false
        holderView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: holderView.topAnchor, constant: 16),
            stackView.bottomAnchor.constraint(equalTo: holderView.bottomAnchor, constant: -16),
            stackView.leadingAnchor.constraint(equalTo: holderView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: holderView.trailingAnchor, constant: -16),
        ])
    }
    // MARK: - Helper Methods
    func createLabel(with title: String) -> UILabel {
        let label       = UILabel()
        label.text      = title + ":"
        label.textColor = AppColor.secondaryLabel
        label.font      = AppFont.SecondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        label.widthAnchor.constraint(equalToConstant: 130).isActive = true
        return label
    }
    
    func createStackView(leftLabel: UILabel, rightLabel: UILabel) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [leftLabel, rightLabel])
        stackView.axis      = .horizontal
        stackView.alignment = .top
        stackView.spacing   = 5
        return stackView
    }
}
