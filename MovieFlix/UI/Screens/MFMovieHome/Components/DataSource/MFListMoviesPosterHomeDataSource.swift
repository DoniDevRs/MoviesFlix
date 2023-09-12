//
//  MFListMoviesHomeDataSource.swift
//  MovieFlix
//
//  Created by Doni on 07/03/23.
//

import UIKit

public protocol MFListMoviesPosterHomeDataSourceDelegate: AnyObject {
    func didSelectItem(with movie: MFMovieEntity)
}

public class MFListMoviesPosterHomeDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegate {
    
    public var movies: [MFMovieEntity]
    public weak var delegate: MFListMoviesPosterHomeDataSourceDelegate?
    
    public init(movies: [MFMovieEntity], delegate: MFListMoviesPosterHomeDataSourceDelegate? = nil) {
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MFMoviePosterViewCell.Constants.reuseID, for: indexPath) as! MFMoviePosterViewCell
        let movie = movies[indexPath.row]
        cell.updateView(with: movie)
        cell.delegate = self
        return cell
    }
}

extension MFListMoviesPosterHomeDataSource: MFMoviePosterViewCellDelegate {
    public func didTapMovieCell(entity: MFMovieEntity) {
        delegate?.didSelectItem(with: entity)
    }
}
