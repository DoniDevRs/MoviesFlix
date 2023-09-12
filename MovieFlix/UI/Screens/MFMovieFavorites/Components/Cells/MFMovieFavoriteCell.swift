//
//  MFMovieFavoriteCell.swift
//  MovieFlix
//
//  Created by Doni on 27/02/23.
//

import UIKit

public class MFMovieFavoriteCell: UITableViewCell {

    enum Constants {
        static let reuseID = "MFMovieFavoriteCell"
        static let videoImageHeight: CGFloat = 128
        static let videoImageWidth: CGFloat = 85
        static let voteButtonWidth: CGFloat = 62
        static let voteLabelText = "voteLabelText".localized
        static let voteImageButton = "star"
        static let fontSizeDetails: CGFloat = 13
        static let releaseLabelText = "releaseLabelText".localized
    }
    
    // MARK: - UI
    
    private lazy var view: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        return view
    }()
    
    private lazy var videoImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = Metrics.tiny
        imageView.clipsToBounds = true
       return imageView
    }()
    
    private lazy var videoTitleLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = .zero
        label.textColor = .systemOrange
        label.font = UIFont.boldSystemFont(ofSize: Metrics.small)
       return label
    }()
    
    private lazy var detailsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = Metrics.tiny
        stackView.distribution = .fill
        stackView.spacing = Metrics.nano
        return stackView
    }()
    
    private lazy var votesStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = Metrics.tiny
        stackView.distribution = .fill
        return stackView
    }()
    
    private lazy var voteTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = .systemGray
        label.text = Constants.voteLabelText
        label.font = UIFont.systemFont(ofSize: Metrics.little)
        return label
    }()
    
    private lazy var voteValueButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: Constants.voteImageButton), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: Constants.fontSizeDetails)
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = Metrics.nano
        return button
    }()
    
    private lazy var fillView: UIView = {
        let fillView = UIView()
        fillView.translatesAutoresizingMaskIntoConstraints = false
        fillView.setContentHuggingPriority(.defaultLow, for: .horizontal)
        return fillView
    }()
    
    private lazy var releaseDateStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = Metrics.tiny
        stackView.alignment = .center
        return stackView
    }()
    
    private lazy var releaseDateTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = .systemGray
        label.text = Constants.releaseLabelText
        label.font = UIFont.systemFont(ofSize: Metrics.little)
        return label
    }()
    
    private lazy var releaseDateValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: Constants.fontSizeDetails)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
        view.addSubview(videoImageView)
        view.addSubview(videoTitleLabel)
        view.addSubview(detailsStackView)
        detailsStackView.addArrangedSubview(votesStackView)
        votesStackView.addArrangedSubview(voteTitleLabel)
        votesStackView.addArrangedSubview(voteValueButton)
        votesStackView.addArrangedSubview(fillView)
        detailsStackView.addArrangedSubview(releaseDateStackView)
        releaseDateStackView.addArrangedSubview(releaseDateTitleLabel)
        releaseDateStackView.addArrangedSubview(releaseDateValueLabel)
        
    }
    
    private func addConstraints() {
        view.constraintToSuperView()
        
        videoImageView.centerYTo(centerYAnchor)
        videoImageView.leadingTo(leadingAnchor, constant: Metrics.padding)
        videoImageView.height(Constants.videoImageHeight)
        videoImageView.width(Constants.videoImageWidth)
        
        videoTitleLabel.topTo(videoImageView.topAnchor, constant: Metrics.nano)
        videoTitleLabel.leadingTo(videoImageView.trailingAnchor, constant: Metrics.little)
        videoTitleLabel.trailingTo(trailingAnchor, constant: Metrics.padding)
        
        detailsStackView.topTo(videoTitleLabel.bottomAnchor, constant: Metrics.nano)
        detailsStackView.leadingTo(videoImageView.trailingAnchor, constant: Metrics.little)
        
        voteValueButton.width(Constants.voteButtonWidth)
        
    }
    
    public func updateView(with movie: MFMovieEntity) {
        self.videoTitleLabel.text = movie.title
        
        guard let posterString = movie.posterPath else {return}
        downloadImage(fromURL: posterString)
        
        let voteAvarageDouble = Double(movie.voteAverage)
        guard let voteAvarageString = voteAvarageDouble?.converToStringWithDecimal() else { return }
        self.voteValueButton.setTitle(" \(voteAvarageString) % ", for: .normal)
        
        self.releaseDateValueLabel.text = movie.releaseDate?.convertToDisplayFormat()
    
    }
    
    private func downloadImage(fromURL url: String) {
        Task { videoImageView.image = await NetworkingImageHandle.shared.downloadPosterCellImage(from: url) }
    }
}
