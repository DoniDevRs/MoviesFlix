//
//  MFListMoviesBackdropHomeView.swift
//  MovieFlix
//
//  Created by Doni on 10/03/23.
//

import UIKit

public protocol MFListMoviesBackdropHomeViewDelegate: AnyObject {
    func goToBackdropDetail(movie: MFMovieEntity)
}

public class MFListMoviesBackdropHomeView: UIView {

    enum Constants {
        static let itemSize = CGSize(width: 272, height: 140)
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
        collectionView.register(MFMovieBackdropViewCell.self, forCellWithReuseIdentifier: MFMovieBackdropViewCell.Constants.reuseID)
        collectionView.backgroundColor = .black
        collectionView.delegate = collectionViewDataSource
        collectionView.dataSource = collectionViewDataSource
        collectionView.backgroundColor = UIColor(hex: DarkColor.secondaryDark.rawValue)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = false
        collectionView.collectionViewLayout.invalidateLayout()
        return collectionView
    }()
    
    // MARK: - PUBLIC API
    
    public weak var delegate: MFListMoviesBackdropHomeViewDelegate?
    private lazy var collectionViewDataSource: MFListMoviesBackdropHomeDataSource = {
        return MFListMoviesBackdropHomeDataSource(movies: [], delegate: self)
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

extension MFListMoviesBackdropHomeView: MFListMoviesBackdropHomeDataSourceDelegate {
    public func didSelectItem(with movie: MFMovieEntity) {
        delegate?.goToBackdropDetail(movie: movie)
    }
}
