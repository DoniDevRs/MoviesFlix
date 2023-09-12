//
//  MFFactory.swift
//  MovieFlix
//
//  Created by Doni on 31/01/23.
//

import UIKit

class MFFactory: MFFactoryProtocol {
    
    let domainDI: DomainDIProtocol
    
    init(domainDI: DomainDIProtocol) {
        self.domainDI = domainDI
    }
    
    func makeMFHomeViewController() -> MFMovieHomeViewController {
        let getListMoviesUseCase = domainDI.resolveGetListMoviesUseCase()
        let viewModel = MFMovieHomeViewModel(getListMoviesUseCase: getListMoviesUseCase)
        let homeMoviesVC = MFMovieHomeViewController(viewModel: viewModel)
        viewModel.viewController = homeMoviesVC
        return homeMoviesVC
    }
    
    func makeMFMovieDetailViewController(movieId: Int) -> MFMovieDetailViewController {
        let getMovieDetailUseCase = domainDI.resolveGetMovieDetailUseCase()
        let getMovieCreditsUseCase = domainDI.resolveGetMovieCreditsUseCase()
        let getMovieVideoUseCase = domainDI.resolveGetMovieVideoUseCase()
        let viewModel = MFMovieDetailViewModel(getMovieDetailUseCase: getMovieDetailUseCase,
                                               getMovieCreditsUseCase: getMovieCreditsUseCase,
                                               getMovieVideoUseCase: getMovieVideoUseCase,
                                               movieId: movieId)
        let movieDetailsVC = MFMovieDetailViewController(viewModel: viewModel)
        viewModel.viewController = movieDetailsVC
        return movieDetailsVC
    }
}
