//
//  MFListMoviesPosterHomeView.swift
//  MovieFlix
//
//  Created by Doni on 07/03/23.
//

import UIKit

public protocol MFListMoviesPosterHomeViewDelegate: AnyObject {
    func goToDetail(movie: MFMovieEntity)
}

public class MFListMoviesPosterHomeView: UIView {

    enum Constants {
        static let itemSize = CGSize(width: 204, height: 306)
    }
    
    // MARK: - UI
    
    private lazy var view: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(hex: DarkColor.secondaryDark.rawValue)
        return view
    }()
    
    private lazy var titleCategory: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: Metrics.medium)
        return label
    }()
    
    private lazy var flowLayout: UICollectionViewFlowLayout = {
       let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.estimatedItemSize = Constants.itemSize
        flowLayout.itemSize = UICollectionViewFlowLayout.automaticSize
        return flowLayout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(MFMoviePosterViewCell.self, forCellWithReuseIdentifier: MFMoviePosterViewCell.Constants.reuseID)
        collectionView.delegate = collectionViewDataSource
        collectionView.dataSource = collectionViewDataSource
        collectionView.backgroundColor = UIColor(hex: DarkColor.secondaryDark.rawValue)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = false
        return collectionView
    }()
    
    // MARK: - PUBLIC API
    
    public weak var delegate: MFListMoviesPosterHomeViewDelegate?
    
    private lazy var collectionViewDataSource: MFListMoviesPosterHomeDataSource = {
        return MFListMoviesPosterHomeDataSource(movies: [], delegate: self)
    }()
    
    // MARK: - INITIALIZERS
    
    override public init(frame: CGRect = .zero) {
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
        view.addSubview(titleCategory)
        view.addSubview(collectionView)
    }
    
    private func addConstraints() {
        view.constraintToSuperView()
        
        titleCategory.topTo(topAnchor, constant: Metrics.little)
        titleCategory.leadingTo(leadingAnchor)
        titleCategory.bottomTo(collectionView.topAnchor, constant: Metrics.little)
        
        collectionView.leadingTo(leadingAnchor)
        collectionView.trailingTo(trailingAnchor)
        collectionView.bottomTo(bottomAnchor)
        
    }
    
    public func updateView(_ movies: [MFMovieEntity], title: String) {
        collectionViewDataSource.update(with: movies)
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            self.titleCategory.text = title
        }
    }
}

extension MFListMoviesPosterHomeView: MFListMoviesPosterHomeDataSourceDelegate {
    public func didSelectItem(with movie: MFMovieEntity) {
        delegate?.goToDetail(movie: movie)
    }
}
