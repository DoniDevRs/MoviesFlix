//
//  MFEmptyStateView.swift
//  MovieFlix
//
//  Created by Doni on 13/03/23.
//

import UIKit

final public class MFEmptyStateView: UIView {
    
    enum Constants {
        static let messageFontSize: CGFloat = 28
        static let imageCenterY: CGFloat = 120
        static let messageHeight: CGFloat = 200
        static let bottomAnchor: CGFloat = 100
    }
    
    private lazy var view: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
       return view
    }()
    
    private lazy var messageLabel: MFTitleLabel = {
        let label = MFTitleLabel(textAlignment: .center, fontSize: Constants.messageFontSize)
        label.numberOfLines = .zero
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
       return label
    }()

    private lazy var logoImageView: UIImageView = {
        let image = UIImageView()
        image.image = Images.emptyMovieState
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
       return image
    }()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setup()
    }
    
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(message: String) {
        self.init(frame: .zero)
        messageLabel.text = message
    }
    
    private func setup() {
        buildViewHierarchy()
        addConstraints()
    }
    
    private func buildViewHierarchy() {
        addSubview(view)
        view.addSubview(logoImageView)
        logoImageView.addSubview(messageLabel)
    }
    
    private func addConstraints() {
        view.constraintToSuperView()
        
        messageLabel.centerYTo(logoImageView.centerYAnchor, constant: -Constants.imageCenterY)
        messageLabel.leadingTo(logoImageView.leadingAnchor, constant: Metrics.big)
        messageLabel.trailingTo(logoImageView.trailingAnchor, constant: Metrics.big)
        messageLabel.height(Constants.messageHeight)

        logoImageView.topTo(view.safeAreaLayoutGuide.topAnchor)
            .leadingTo(view.leadingAnchor)
            .trailingTo(view.trailingAnchor)
            .bottomTo(view.safeAreaLayoutGuide.bottomAnchor)
        
    }
}
