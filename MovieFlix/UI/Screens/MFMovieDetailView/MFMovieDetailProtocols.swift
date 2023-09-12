//
//  MFMovieDetailProtocols.swift
//  MovieFlix
//
//  Created by Doni on 30/01/23.
//

import Foundation

public protocol MFMovieDetailViewControllerProtocol: AnyObject {
    var contentView: MFMovieDetailProtocol? { get }
    var viewModel: MFMovieDetailViewModelProtocol? { get }
    
    func updateView(with viewState: MFMovieDetailViewState)
    func showDialog(with dialog: DialogEntity)
    func presentSafariVC(with url: URL)
    func presentMFDialogOnMainThread(_ dialogEntity: DialogEntity)
}

public protocol MFMovieDetailViewModelProtocol: AnyObject {
    var viewController: MFMovieDetailViewControllerProtocol? { get }
    var viewState: MFMovieDetailViewState { get }
    
    func initState()
    func getMovieVideo()
    func likeMovieTapped()
}

public protocol MFMovieDetailViewControllerDelegate: AnyObject {
    
}
