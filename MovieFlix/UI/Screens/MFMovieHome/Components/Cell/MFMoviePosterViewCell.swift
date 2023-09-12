//
//  MFMoviePosterViewCell.swift
//  MovieFlix
//
//  Created by Doni on 07/03/23.
//

import UIKit

public protocol MFMoviePosterViewCellDelegate: AnyObject {
    func didTapMovieCell(entity: MFMovieEntity)
}

public class MFMoviePosterViewCell: UICollectionViewCell {
    
    public weak var delegate: MFMoviePosterViewCellDelegate?
    
    enum Constants {
        static let reuseID = "MoviePosterViewCell"
        static let videoImageSize = CGSize(width: 204, height: 306)
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
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = Metrics.tiny
        imageView.clipsToBounds = true
       return imageView
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
        
    }
    
    private func addConstraints() {
        view.constraintToSuperView()
        videoImageView.constraintToSuperView()
        videoImageView.width(Constants.videoImageSize.width)
        videoImageView.height(Constants.videoImageSize.height)
        
    }
    
    public func updateView(with movie: MFMovieEntity) {
        viewEntity = movie
        guard let posterString = movie.posterPath else {return}
        downloadImage(fromURL: posterString)
    }
    
    private func downloadImage(fromURL url: String) {
        Task { videoImageView.image = await NetworkingImageHandle.shared.downloadPosterCellImage(from: url) }
    }
    
    @objc private func didTapMovieCell() {
        guard let entity = viewEntity else { return }
        delegate?.didTapMovieCell(entity: entity)
    }
    
}

