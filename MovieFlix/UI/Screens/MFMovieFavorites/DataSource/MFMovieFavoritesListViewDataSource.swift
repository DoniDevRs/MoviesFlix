//
//  MFMovieFavoritesListViewDataSource.swift
//  MovieFlix
//
//  Created by Doni on 27/02/23.
//

import UIKit

public protocol MFMovieFavoritesListViewDataSourceDelegate: AnyObject {
    func didSelectItem(with entity: MFMovieEntity)
    func showRemoveError(with dialog: DialogEntity)
}

open class MFMovieFavoritesListViewDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    enum Constants {
        static let unableToRemove = "unableToRemove".localized
    }
    
    
    public var favorites: [MFMovieEntity]
    public weak var delegate: MFMovieFavoritesListViewDataSourceDelegate?
    
    public init(favorites: [MFMovieEntity], delegate: MFMovieFavoritesListViewDataSourceDelegate? = nil) {
        self.favorites = favorites
        self.delegate = delegate
    }
    
    public func update(with favorites: [MFMovieEntity]) {
        self.favorites = favorites
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MFMovieFavoriteCell.Constants.reuseID) as! MFMovieFavoriteCell
        let favorite = favorites[indexPath.row]
        cell.updateView(with: favorite)
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        (delegate)?.didSelectItem(with: favorites[indexPath.row])
    }
    
    public func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        
        PersistenceManager.updateWith(favorite: favorites[indexPath.row], actionType: .remove) { [weak self] error in
            guard let self = self else { return }
            guard let error = error else {
                self.favorites.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .left)
                return
            }
            let alert = DialogEntity(title: Constants.unableToRemove,
                                    message: error.localizedDescription,
                                    buttonTitle: "Ok")
            self.delegate?.showRemoveError(with: alert)
        }
    }
}
