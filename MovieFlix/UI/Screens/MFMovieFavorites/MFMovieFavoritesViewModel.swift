//
//  MFMovieFavoritesViewModel.swift
//  MovieFlix
//
//  Created by Doni on 27/02/23.
//

import Foundation

public class MFMovieFavoritesViewModel: MFMovieFavoritesViewModelProtocol {
    
    enum Constants {
        static let errorDialogTitle = "errorDialogTitle".localized
        static let buttonOk = "Ok"
    }
    
    // MARK: - PROPERTIES
    
    public weak var viewController: MFMovieFavoritesViewControllerProtocol?
    public var viewState: MFMovieFavoritesViewState = .isEmpty {
        didSet {
            viewController?.updateView(with: viewState)
        }
    }
    
    // MARK: - PUBLIC INITIALIZERS
    
    public init() {}
    
    public func initState() {
        getFavorites()
    }
    
    private func getFavorites() {
        viewState = .isLoading(true)
        PersistenceManager.retrieveFavorites { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(favorites):
                self.viewState = .hasData(favorites)
            case .failure(let error):
                let alert = DialogEntity(title: Constants.errorDialogTitle,
                                         message: error.localizedDescription,
                                         buttonTitle: Constants.buttonOk)
                self.viewController?.presentMFDialogOnMainThread(alert)
            }
        }
        viewState = .isLoading(false)
    }
}
