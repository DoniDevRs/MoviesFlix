//
//  MFListMoviesBackdropHomeDataSource.swift
//  MovieFlix
//
//  Created by Doni on 10/03/23.
//

import UIKit

public protocol MFListMoviesBackdropHomeDataSourceDelegate: AnyObject {
    func didSelectItem(with movie: MFMovieEntity)
}

public class MFListMoviesBackdropHomeDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegate {
    
    public var movies: [MFMovieEntity]
    public weak var delegate: MFListMoviesBackdropHomeDataSourceDelegate?
    
    public init(movies: [MFMovieEntity], delegate: MFListMoviesBackdropHomeDataSourceDelegate? = nil) {
        self.movies = movies
        self.delegate = delegate
    }
    
    public func update(with movies: [MFMovieEntity]) {
        self.movies = movies
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MFMovieBackdropViewCell.Constants.reuseID, for: indexPath) as! MFMovieBackdropViewCell
        let movie = movies[indexPath.row]
        cell.updateView(with: movie, title: movie.title)
        cell.delegate = self
        return cell
    }
}

extension MFListMoviesBackdropHomeDataSource: MFMovieBackdropViewCellDelegate {
    public func didTapMovieCell(entity: MFMovieEntity) {
        delegate?.didSelectItem(with: entity)
    }
}
