//
//  MFTitleWithSubtitleView.swift
//  MovieFlix
//
//  Created by Doni on 22/02/23.
//

import UIKit

public struct MFTitleWithSubtitleViewEntity {
    public let title: String?
    public let subTitle: String?
    public let alignment: NSTextAlignment?
    
    public init(title: String?, subTitle: String?, alignment: NSTextAlignment?) {
        self.title = title
        self.subTitle = subTitle
        self.alignment = alignment
    }
}

public class MFTitleWithSubtitleView: UIView {

    enum Constants {
        static let titleFontSize: CGFloat = 14
    }
    
    // MARK: - UI
    
    private lazy var view: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        return view
    }()
    
    private lazy var titleLabel: MFTitleLabel = {
        let titleLabel = MFTitleLabel(textAlignment: .left, fontSize: Constants.titleFontSize)
        titleLabel.textColor = .white
        return titleLabel
    }()
    
    private lazy var subtitleLabel: MFBodyLabel = {
        let subtitleLabel = MFBodyLabel(textAlignment: .left)
        subtitleLabel.font = UIFont.systemFont(ofSize: Metrics.little)
        subtitleLabel.textColor = .white
        return subtitleLabel
    }()
    
    override init(frame: CGRect) {
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
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
    }
    
    private func addConstraints() {
        view.constraintToSuperView()
        
        titleLabel.topTo(view.topAnchor)
            .leadingTo(view.leadingAnchor)
            .trailingTo(view.trailingAnchor)
        
        subtitleLabel.topTo(titleLabel.bottomAnchor)
            .leadingTo(view.leadingAnchor)
            .trailingTo(view.trailingAnchor)
            .bottomTo(view.bottomAnchor)
        
    }
    
    public func updateView(with entity: MFTitleWithSubtitleViewEntity) {
        titleLabel.text = entity.title
        subtitleLabel.text = entity.subTitle
    }
    
    public func updateCastView(with entity: MovieCastEntity) {
        titleLabel.text = entity.name
        subtitleLabel.text = entity.character
    }
    
    public func updateCrewView(with entity: MovieCrewEntity) {
        titleLabel.text = entity.name
        subtitleLabel.text = entity.job
    }
}

