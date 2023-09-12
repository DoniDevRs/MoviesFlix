//
//  MFMovieHomeViewModel.swift
//  MovieFlix
//
//  Created by Doni on 30/01/23.
//

import Foundation
import RxSwift

public class MFMovieHomeViewModel: MFMovieHomeViewModelProtocol {
    
    enum Constants {
        static let buttonAlertOk = "Ok!"
    }
   
    public weak var viewController: MFMovieHomeViewControllerProtocol?
    public var viewState: MFMovieHomeViewState = .isEmpty {
        didSet {
            viewController?.updateView(with: viewState)
        }
    }

    private let getListMoviesUseCase: GetListMoviesUseCaseProtocol
    private let disposeBag = DisposeBag()
    typealias UseCaseGetListMovies = Result<GetListMoviesUseCaseResponse, MFError>
    
    
    // MARK: - PUBLIC INITIALIZERS

    public init(getListMoviesUseCase: GetListMoviesUseCaseProtocol) {
        self.getListMoviesUseCase = getListMoviesUseCase
    }

    public func initState() {
        getListMovies()
    }
    
    // MARK: - NOWPLAYING MOVIES API
    
    private func getListMovies() {
        viewState = .isLoading(true)
        getListMoviesUseCase.execute(from: MovieListEndPoint.nowPlaying.rawValue).subscribeOnMainDisposed(by: disposeBag) { [weak self] in
            self?.handleGetListMovies($0, endPoint: .nowPlaying)
        }
        getListMoviesUseCase.execute(from: MovieListEndPoint.upcoming.rawValue).subscribeOnMainDisposed(by: disposeBag) { [weak self] in
            self?.handleGetListMovies($0, endPoint: .upcoming)
        }
        getListMoviesUseCase.execute(from: MovieListEndPoint.topRated.rawValue).subscribeOnMainDisposed(by: disposeBag) { [weak self] in
            self?.handleGetListMovies($0, endPoint: .topRated)
        }
        getListMoviesUseCase.execute(from: MovieListEndPoint.popular.rawValue).subscribeOnMainDisposed(by: disposeBag) { [weak self] in
            self?.handleGetListMovies($0, endPoint: .popular)
        }
    }
    
    private func handleGetListMovies(_ result: UseCaseGetListMovies, endPoint: MovieListEndPoint) {
        switch result {
        case let .success(response):
            switch endPoint {
            case .nowPlaying:
                self.showMoviesScreen(response, movieCategory: .nowPlaying)
            case .upcoming:
                self.showMoviesScreen(response, movieCategory: .upcoming)
            case .topRated:
                self.showMoviesScreen(response, movieCategory: .topRated)
            case .popular:
                self.showMoviesScreen(response, movieCategory: .popular)
            }
        case let .failure(error):
            self.showDialog(self.makeDialog(error.localizedDescription))
        }
        viewState = .isLoading(false)
    }
    
    private func showMoviesScreen(_ data: GetListMoviesUseCaseResponse?, movieCategory: MovieListEndPoint) {
        guard let data = data else {
            return
        }
        switch movieCategory {
        case .nowPlaying:
            let entity = MFMovieHomeFactoryEntity(data: data).makeListMoviesEntity()
            self.viewState = .hasNowPlaying(entity)
            
        case .upcoming:
            let entity = MFMovieHomeFactoryEntity(data: data).makeListMoviesEntity()
            self.viewState = .hasUpcoming(entity)
            
        case .topRated:
            let entity = MFMovieHomeFactoryEntity(data: data).makeListMoviesEntity()
            self.viewState = .hasTopRated(entity)
            
        case .popular:
            let entity = MFMovieHomeFactoryEntity(data: data).makeListMoviesEntity()
            self.viewState = .hasPopular(entity)
        }
    }
    
    // MARK: = UTILS
    
    private func showDialog(_ dialogEntity: DialogEntity?) {
        guard let dialog = dialogEntity else { return }
        viewController?.showDialog(with: dialog)
    }
    
    private func makeDialog(_ error: String) -> DialogEntity {
        DialogEntity(title: nil, message: error, buttonTitle: Constants.buttonAlertOk)
    }
    
}
