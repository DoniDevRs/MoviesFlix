//
//  MFMovieDetailPosterImageView.swift
//  MovieFlix
//
//  Created by Doni on 30/01/23.
//

import Foundation
import UIKit

public class MFMovieDetailPosterImageView: UIView {
    
    enum Constants {
        static let posterImageHeight: CGFloat = 490
        static let posterImageWidth: CGFloat = 414
        static let titleLabelTop: CGFloat = 400
        static let titleLabelFontSize: CGFloat = 30
        static let imageAlpha: CGFloat = 0.4
        static let minutes = "minutes".localized
    }
        
    // MARK: - UI
    
    private lazy var view: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        return view
    }()
    
    private lazy var posterImage: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.alpha = Constants.imageAlpha
        return image
    }()
    
    private lazy var titleLabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = .zero
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: Constants.titleLabelFontSize)
       return label
    }()
    
    private lazy var stackMovieInformations: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = Metrics.nano
        stackView.distribution = .fill
        return stackView
    }()
    
    private lazy var yearLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = .systemGray2
        label.font = UIFont.boldSystemFont(ofSize: Metrics.little)
        return label
    }()
    
    private lazy var durationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = .systemGray2
        label.font = UIFont.boldSystemFont(ofSize: Metrics.little)
        return label
    }()
    
    private lazy var fillView: UIView = {
        let fillView = UIView()
        fillView.translatesAutoresizingMaskIntoConstraints = false
        fillView.setContentHuggingPriority(.defaultLow, for: .horizontal)
        return fillView
    }()
    
    // MARK: PUBLIC INITIALIZERS
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - PRIVATE
    
    private func setup() {
       buildViewHierarchy()
       addConstrainsts()
    }
    
    private func buildViewHierarchy() {
        addSubview(view)
        view.addSubview(posterImage)
        view.addSubview(titleLabel)
        view.addSubview(stackMovieInformations)
        stackMovieInformations.addArrangedSubview(yearLabel)
        stackMovieInformations.addArrangedSubview(durationLabel)
        stackMovieInformations.addArrangedSubview(fillView)
        
    }
    
    private func addConstrainsts() {
        view.constraintToSuperView()
        
        posterImage.topTo(topAnchor)
        posterImage.trailingTo(trailingAnchor)
        posterImage.leadingTo(leadingAnchor)
        posterImage.bottomTo(bottomAnchor)
        posterImage.height(Constants.posterImageHeight)
        posterImage.width(Constants.posterImageWidth)
        
        
        titleLabel.leadingTo(leadingAnchor, constant: Metrics.padding)
        titleLabel.trailingTo(trailingAnchor, constant: Metrics.padding)
        titleLabel.bottomTo(stackMovieInformations.topAnchor, constant: Metrics.nano)
        
        stackMovieInformations.leadingTo(leadingAnchor, constant: Metrics.padding)
        stackMovieInformations.trailingTo(trailingAnchor, constant: Metrics.padding)
        stackMovieInformations.bottomTo(posterImage.bottomAnchor, constant: Metrics.nano)
        
    }
    
    public func updateView(_ movie: MFMovieDetailEntity) {
        DispatchQueue.main.async {
            self.titleLabel.text = movie.title
            self.yearLabel.text = movie.yearText
            self.durationLabel.text = " - \(movie.durationText) \(Constants.minutes)"
        }
        
        guard let backDropString = movie.backdropPath else {return}
        downloadImage(fromURL: backDropString)
    }
    
    private func downloadImage(fromURL url: String) {
        Task { posterImage.image = await NetworkingImageHandle.shared.downloadPosterDetailImage(from: url) }
    }
}
