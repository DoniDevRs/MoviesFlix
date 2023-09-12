//
//  MFMovieIntroView.swift
//  MovieFlix
//
//  Created by Doni on 30/01/23.
//

import UIKit

final public class MFMovieIntroView: UIView, MFMovieIntroViewProtocol {
    
    public weak var delegate: MFMovieIntroViewDelegate?
    
    enum Constants {
        static let logoIntroSize: CGFloat = 54
        static let fontSizeTitle: CGFloat = 24
        static let fontSizeSubTitle: CGFloat = 14
        static let buttonRadius: CGFloat = 8
        static let buttonFontSize: CGFloat = 18
        static let buttonWidth: CGFloat = 140
        static let title = "titleHome".localized
        static let subtitle = "subtitleHome".localized
        static let enterButton = "enterButtonHome".localized
    }
    
    // MARK: - UI
    
    private lazy var view: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.alignment = .center
        stackView.spacing = Metrics.small
        return stackView
    }()
    
    private lazy var logoIntroView: UIImageView = {
        let image = UIImageView()
        image.image = Images.logoIntro
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var titleIntro: MFTitleLabel = {
        let label = MFTitleLabel(textAlignment: .center,
                                fontSize: Constants.fontSizeTitle)
        label.text = Constants.title
        label.textColor = .white
        return label
    }()
    
    private lazy var contentSubTitle: UIView = {
        let contentButton = UIView()
        contentButton.translatesAutoresizingMaskIntoConstraints = false
        return contentButton
    }()
    
    private lazy var subTitleIntro: MFSecondaryTitleLabel = {
        let label = MFSecondaryTitleLabel(fontSize: Constants.fontSizeSubTitle)
        label.text = Constants.subtitle
        label.textColor = .systemGray6
        label.textAlignment = .center
        label.numberOfLines = .zero
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: Metrics.small)
        return label
    }()
    
    private lazy var contentButton: UIView = {
        let contentButton = UIView()
        contentButton.translatesAutoresizingMaskIntoConstraints = false
        return contentButton
    }()
    
    private lazy var buttonEnter: MFButton = {
        let button = MFButton()
        button.set(color: UIColor.orange,
                   title: Constants.enterButton,
                   font: UIFont.systemFont(ofSize: Constants.buttonFontSize, weight: .bold))
        button.layer.cornerRadius = Constants.buttonRadius
        button.addTarget(self, action: #selector(didTapButtonEnter), for:.touchUpInside)
        return button
    }()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - PRIVATE
    
    private func setup() {
        buildViewHierarchy()
        addConstraints()
    }
    
    private func buildViewHierarchy() {
        addSubview(view)
        
        view.addSubview(stackView)
        stackView.addArrangedSubview(logoIntroView)
        stackView.addArrangedSubview(titleIntro)
        stackView.addArrangedSubview(contentSubTitle)
        contentSubTitle.addSubview(subTitleIntro)
        stackView.addArrangedSubview(contentButton)
        contentButton.addSubview(buttonEnter)
        
    }
    
    private func addConstraints() {
        view.constraintToSuperView()
        
        stackView.centerXTo(view.centerXAnchor)
        stackView.centerYTo(view.centerYAnchor)
        subTitleIntro.constraintToSuperView()
        
        buttonEnter.constraintToSuperView(leading: Metrics.little, trailing: -Metrics.little)
        buttonEnter.height(Metrics.big)
        buttonEnter.width(Constants.buttonWidth)
    
    }
    
    @objc private func didTapButtonEnter() {
        delegate?.didTapButtonEnter()
    }
   
}
