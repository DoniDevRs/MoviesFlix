//
//  MFMovieHomeProtocols.swift
//  MovieFlix
//
//  Created by Doni on 30/01/23.
//

public protocol MFMovieHomeViewControllerProtocol: AnyObject {
    var contentView: MFMovieHomeViewProtocol? { get }
    var viewModel: MFMovieHomeViewModelProtocol? { get }
    
    func updateView(with viewState: MFMovieHomeViewState)
    func showDialog(with dialog: DialogEntity)
}

public protocol MFMovieHomeViewModelProtocol: AnyObject {
    var viewController: MFMovieHomeViewControllerProtocol? { get }
    var viewState: MFMovieHomeViewState { get }
    
    func initState()
}

public protocol MFMovieHomeViewControllerDelegate: AnyObject {
    func goToMovieDetail(movieId: Int)
}
    
