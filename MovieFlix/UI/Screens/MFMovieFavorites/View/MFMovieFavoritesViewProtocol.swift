//
//  MFMovieFavoritesViewProtocol.swift
//  MovieFlix
//
//  Created by Doni on 27/02/23.
//

import UIKit

public protocol MFMovieFavoritesViewProtocol: AnyObject {
    var content: UIView { get }
    var delegate: MFMovieFavoritesViewDelegate? { get set }
    
    func updateView(with viewState: MFMovieFavoritesViewState)
}

public protocol MFMovieFavoritesViewDelegate: AnyObject {
    func goToMovieDetail(entity: MFMovieEntity)
    func showRemoveError(with dialog: DialogEntity)
}

extension MFMovieFavoritesViewProtocol where Self: UIView {
    public var content: UIView { return self }
}
