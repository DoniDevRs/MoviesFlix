//
//  MFMovieFavoritesViewController.swift
//  MovieFlix
//
//  Created by Doni on 27/02/23.
//

import UIKit

public class MFMovieFavoritesViewController: UIViewController {

    private enum Constants {
        static let title = "titleFavorites".localized
    }
    
    // MARK: PROPERTIES
    
    public let contentView: MFMovieFavoritesViewProtocol?
    public let viewModel: MFMovieFavoritesViewModelProtocol?
    
    // MARK: - PUBLIC API
    
    public weak var delegate: MFMovieFavoritesViewControllerDelegate?
    
    // MARK: - INITIALIZERS
    
    public init(contentView: MFMovieFavoritesViewProtocol = MFMovieFavoritesView(), viewModel: MFMovieFavoritesViewModelProtocol) {
        self.contentView = contentView
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.initState()
        configureNavigationBar(largeTitleColor: .white, backgoundColor: .black, tintColor: .white, title: Constants.title, preferredLargeTitle: true)
    }
    
    private func setup() {
        contentSetup()
    }
    
    private func contentSetup() {
        if let contentView = contentView {
            self.view = contentView.content
        }
        contentView?.delegate = self
    }
    
}

extension MFMovieFavoritesViewController: MFMovieFavoritesViewDelegate {
    public func goToMovieDetail(entity: MFMovieEntity) {
        delegate?.goToMovieDetail(entity: entity)
    }
    
    public func showRemoveError(with dialog: DialogEntity) {
        presentMFDialogOnMainThread(dialog) 
    }
}

extension MFMovieFavoritesViewController: MFMovieFavoritesViewControllerProtocol {
    public func updateView(with viewState: MFMovieFavoritesViewState) {
        contentView?.updateView(with: viewState)
    }
}


