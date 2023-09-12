//
//  MFMovieBackdropViewCell.swift
//  MovieFlix
//
//  Created by Doni on 10/03/23.
//

import UIKit

public protocol MFMovieBackdropViewCellDelegate: AnyObject {
    func didTapMovieCell(entity: MFMovieEntity)
}

public class MFMovieBackdropViewCell: UICollectionViewCell {
    
    public weak var delegate: MFMovieBackdropViewCellDelegate?
    
    enum Constants {
        static let reuseID = "MovieBackdropViewCell"
        static let videoImageSize = CGSize(width: 272, height: 140)
        static let fontTitleSize: CGFloat = 14
    }
    
    // MARK: - UI
    
    private lazy var view: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(hex: DarkColor.secondaryDark.rawValue)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapMovieCell)))
        return view
    }()
    
    private lazy var videoImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = Metrics.tiny
        imageView.clipsToBounds = true
       return imageView
    }()
    
    private lazy var titleMovieLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: Constants.fontTitleSize, weight: .medium)
        return label
    }()
    
    private var viewEntity: MFMovieEntity?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        buildViewHierarchy()
        addConstraints()
    }
    
    private func buildViewHierarchy() {
        addSubview(view)
        view.addSubview(videoImageView)
        view.addSubview(titleMovieLabel)
        
    }
    
    private func addConstraints() {
        view.constraintToSuperView()
        
        videoImageView.topTo(topAnchor)
        videoImageView.leadingTo(leadingAnchor)
        videoImageView.trailingTo(trailingAnchor)
        videoImageView.width(Constants.videoImageSize.width)
        videoImageView.height(Constants.videoImageSize.height)
        
        titleMovieLabel.topTo(videoImageView.bottomAnchor, constant: Metrics.nano)
        titleMovieLabel.leadingTo(leadingAnchor)
        titleMovieLabel.trailingTo(trailingAnchor)
        titleMovieLabel.bottomTo(bottomAnchor)
        
    }
    
    public func updateView(with movie: MFMovieEntity, title: String) {
        viewEntity = movie
        titleMovieLabel.text = title
        guard let backdropString = movie.backdropPath else {return}
        downloadImage(fromURL: backdropString)
    }
    
    private func downloadImage(fromURL url: String) {
        Task { videoImageView.image = await NetworkingImageHandle.shared.downloadBackdropCellImage(from: url) }
    }
    
    @objc private func didTapMovieCell() {
        guard let entity = viewEntity else { return }
        delegate?.didTapMovieCell(entity: entity)
    }
    
}
