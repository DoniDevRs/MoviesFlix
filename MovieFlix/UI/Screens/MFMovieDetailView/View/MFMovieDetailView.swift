//
//  MFMovieDetailView.swift
//  MovieFlix
//
//  Created by Doni on 30/01/23.
//

import Foundation
import UIKit

public protocol MFMovieDetailViewDelegate: AnyObject {
    func didTapButtonWatchTrailer()
}

final public class MFMovieDetailView: UIView {
    
    enum Constants {
        static let buttonWatchTitle = "buttonWatchTitle".localized
        static let buttonWatchRadius: CGFloat = 8
        static let buttonWatchFontSize: CGFloat = 16
        static let buttonWatchWidth: CGFloat = 312
    }
    
    // MARK: - UI
    
    private lazy var view: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        return view
    }()
    
    private lazy var scrollView: UIScrollView = {
       let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
       return scrollView
    }()
    
    private lazy var contentScroll: UIView = {
       let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    private lazy var stackView: UIStackView = {
       let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = Metrics.small
        return stackView
    }()
    
    private lazy var contentPosterImage: UIView = {
        let contentPosterImage = UIView()
        contentPosterImage.translatesAutoresizingMaskIntoConstraints = false
        return contentPosterImage
    }()
    
    private lazy var posterImage: MFMovieDetailPosterImageView = {
       let image = MFMovieDetailPosterImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var contentOverView: UIView = {
        let contentOverView = UIView()
        contentOverView.translatesAutoresizingMaskIntoConstraints = false
        return contentOverView
    }()
    
    private lazy var overView: MFMovieDetailOverView = {
       let overView = MFMovieDetailOverView()
        overView.translatesAutoresizingMaskIntoConstraints = false
       return overView
    }()
    
    private lazy var footerView: UIView = {
        let footerView = UIView()
        footerView.translatesAutoresizingMaskIntoConstraints = false
        return footerView
    }()
    
    private lazy var buttonWatchTrailer: MFButton = {
        let button = MFButton()
        button.set(color: UIColor.orange,
                   title: Constants.buttonWatchTitle,
                   font: UIFont.systemFont(ofSize: Constants.buttonWatchFontSize, weight: .bold))
        button.layer.cornerRadius = Constants.buttonWatchRadius
        button.addTarget(self, action: #selector(didTapButtonWatchTrailer), for:.touchUpInside)
        return button
    }()
    
    private lazy var loadingView: MFLoadingView = {
        let loadingView = MFLoadingView()
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        return loadingView
    }()
    
    // MARK: - PUBLIC API
    
    public weak var delegate: MFMovieDetailViewDelegate?
    
    // MARK: INITIALIZERS
    
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
        view.addSubview(scrollView)
        scrollView.addSubview(contentScroll)
        contentScroll.addSubview(stackView)
        view.addSubview(footerView)
        footerView.addSubview(buttonWatchTrailer)
        
        stackView.addArrangedSubview(contentPosterImage)
        contentPosterImage.addSubview(posterImage)
        stackView.addArrangedSubview(contentOverView)
        contentOverView.addSubview(overView)
        view.addSubview(loadingView)
    }
    
    private func addConstraints() {
        view.constraintToSuperView(top: -Metrics.big)

        contentScroll.constraintToSuperView()
        contentScroll.width(widthAnchor)
        
        stackView.constraintToSuperView()
        posterImage.constraintToSuperView()
        overView.constraintToSuperView()
        
        scrollView
            .topTo(view.topAnchor)
            .leadingTo(view.leadingAnchor)
            .trailingTo(view.trailingAnchor)
            .bottomTo(footerView.topAnchor, constant: Metrics.little)
        
        footerView.bottomTo(view.bottomAnchor)
            .leadingTo(view.leadingAnchor)
            .trailingTo(view.trailingAnchor)
        
        buttonWatchTrailer
            .leadingTo(footerView.leadingAnchor, constant: Metrics.medium)
            .trailingTo(footerView.trailingAnchor, constant: Metrics.medium)
            .topTo(footerView.topAnchor, constant: Metrics.small)
            .bottomTo(footerView.bottomAnchor, constant: Metrics.medium)
            .height(Metrics.big)
        
        loadingView.constraintToSuperView()

    }
    
    private func updateView(with entity: MFMovieDetailEntity) {
        self.overView.updateView(entity)
        self.posterImage.updateView(entity)
    }
    
    @objc private func didTapButtonWatchTrailer() {
        delegate?.didTapButtonWatchTrailer()
    }
    
    private func updateViewLoading(show: Bool) {
        DispatchQueue.main.async {
            self.loadingView.isHidden = !show
        }
    }
}

extension MFMovieDetailView: MFMovieDetailProtocol {
    public func updateView(with viewState: MFMovieDetailViewState) {
        switch viewState {
        case let .hasData(data):
            updateView(with: data)
        case let .isLoading(show):
            updateViewLoading(show: show)
        case .isEmpty:
            break
        }
    }
}
