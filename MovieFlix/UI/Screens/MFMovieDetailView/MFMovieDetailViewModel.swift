//
//  MFMovieDetailViewModel.swift
//  MovieFlix
//
//  Created by Doni on 30/01/23.
//

import Foundation
import RxSwift

public class MFMovieDetailViewModel: MFMovieDetailViewModelProtocol {
    
    enum Constants {
        static let titleAlertSuccess = "titleAlertSuccess".localized
        static let messageAlertSuccess = "messageAlertSuccess".localized
        static let messageAlertFailure = "messageAlertFailure".localized
        static let buttonAlertOk = "Ok"
    }
    
    public var viewController: MFMovieDetailViewControllerProtocol?
    public var viewState: MFMovieDetailViewState = .isEmpty {
        didSet {
            viewController?.updateView(with: viewState)
        }
    }

    private let getMovieDetailUseCase: GetMovieDetailUseCaseProtocol
    typealias UseCaseGetMovieDetailUseCase = Result<GetMovieDetailUseCaseResponse, MFError>
    private let getMovieCreditsUseCase: GetMovieCreditsUseCaseProtocol
    typealias UseCaseGetMovieCreditsUseCase = Result<GetMovieCreditsUseCaseResponse, MFError>
    private let getMovieVideoUseCase: GetMovieVideoUseCaseProtocol
    typealias UseCaseGetMovieVideoUseCase = Result<GetMovieVideoUseCaseResponse, MFError>
    private var viewMovieDetailData: GetMovieDetailUseCaseResponse?
    private var viewMovieCreditsData: GetMovieCreditsUseCaseResponse?
    private let disposeBag = DisposeBag()
    
    private var movieId: Int

    // MARK: - PUBLIC INITIALIZERS
    
    public init(getMovieDetailUseCase: GetMovieDetailUseCaseProtocol, getMovieCreditsUseCase: GetMovieCreditsUseCaseProtocol, getMovieVideoUseCase: GetMovieVideoUseCaseProtocol,
                movieId: Int) {
        self.getMovieDetailUseCase = getMovieDetailUseCase
        self.getMovieCreditsUseCase = getMovieCreditsUseCase
        self.getMovieVideoUseCase = getMovieVideoUseCase
        self.movieId = movieId
    }

    public func initState() {
        getMovieDetail()
        getMovieCredits()
    }

    // MARK: - MOVIE DETAIL API
    
    private func getMovieDetail() {
        viewState = .isLoading(true)
        getMovieDetailUseCase.execute(movieId: movieId).subscribeOnMainDisposed(by: disposeBag) { [weak self] in
            self?.handleGetMovieDetail($0)
        }
    }
    
    private func handleGetMovieDetail(_ result: UseCaseGetMovieDetailUseCase ) {
        switch result {
        case let .success(response):
            self.viewMovieDetailData = response
            self.showMovieDetailScreen(response, creditsData: nil)
        case let .failure(error):
            self.showDialog(self.makeDialog(error.localizedDescription))
        }
    }
    
    // MARK: - MOVIE CREDITS API
    
    private func getMovieCredits() {
        viewState = .isLoading(true)
        getMovieCreditsUseCase.execute(movieId: movieId).subscribeOnMainDisposed(by: disposeBag) { [weak self] in
            self?.handleGetMovieCredits($0)
        }
    }
    
    private func handleGetMovieCredits(_ result: UseCaseGetMovieCreditsUseCase ) {
        switch result {
        case let .success(response):
            self.viewMovieCreditsData = response
            self.showMovieDetailScreen(nil, creditsData: response)
            self.viewState = .isLoading(false)
        case let .failure(error):
            self.showDialog(self.makeDialog(error.localizedDescription))
        }
    }
    
    // MARK: - MOVIE VIDEO API

    public func getMovieVideo() {
        getMovieVideoUseCase.execute(movieId: movieId).subscribeOnMainDisposed(by: disposeBag) { [weak self] in
            self?.handleGetMovieVideo($0)
        }
    }
    
    private func handleGetMovieVideo(_ result: UseCaseGetMovieVideoUseCase ) {
        switch result {
        case let .success(response):
            self.getMovieURL(response)
        case let .failure(error):
            self.showDialog(self.makeDialog(error.localizedDescription))
        }
    }
    
    private func getMovieURL(_ movieResponse: GetMovieVideoUseCaseResponse) {
        let movie = movieResponse.results.map { MovieVideo(id: $0.id,
                                                           key: $0.key,
                                                           name: $0.name,
                                                           site: $0.site)
        }
        movie.forEach { movie in
            guard movie.site == "YouTube" else {
                return
            }
            var youtubeURL: URL? {
                return URL(string: "https://youtube.com/watch?v=\(movie.key)")
            }
            guard let youtubeURL = youtubeURL else {
                return
            }
            self.viewController?.presentSafariVC(with: youtubeURL)
        }
    }
    
    // MARK: - SHOWMOVIESCREEN
    
    private func showMovieDetailScreen(_ data: GetMovieDetailUseCaseResponse?, creditsData: GetMovieCreditsUseCaseResponse?) {
        guard let data = viewMovieDetailData, let creditsData = viewMovieCreditsData else {
            return
        }
        
        let entity = MFMovieDetailFactoryEntity(data: data, creditsData: creditsData).make()
        self.viewState = .hasData(entity)
    }
    
    // MARK: - PERSISTENCE
    
    public func likeMovieTapped() {
        getMovieInfo()
    }
    
    private func getMovieInfo() {
        getMovieDetailUseCase.execute(movieId: movieId).subscribeOnMainDisposed(by: disposeBag) {  [weak self] in
            self?.handleGetMovieInfo($0)
        }
    }
    
    private func handleGetMovieInfo(_ result: UseCaseGetMovieDetailUseCase ) {
        switch result {
        case let .success(response):
            self.addUserToFavorites(movie: response)
        case let .failure(error):
            self.showDialog(self.makeDialog(error.localizedDescription))
        }
    }
    
    private func addUserToFavorites(movie: GetMovieDetailUseCaseResponse) {
        let movie = MFMovieEntity(id: movie.id,
                                title: movie.title,
                                posterPath: movie.posterPath,
                                releaseDate: movie.releaseDate,
                                voteCount: String(movie.voteCount),
                                language: movie.originalLanguage,
                                voteAverage: String(movie.voteAverage),
                                backdropPath: movie.backdropPath
        )
        PersistenceManager.updateWith(favorite: movie, actionType: .add) { [weak self] error in
            guard let self = self else { return }
            
            guard let error = error else {
                let alert = DialogEntity(title: Constants.titleAlertSuccess,
                                         message: Constants.messageAlertSuccess,
                                         buttonTitle: Constants.buttonAlertOk)
                self.viewController?.presentMFDialogOnMainThread(alert)
                return
            }
            let alert = DialogEntity(title: Constants.messageAlertFailure,
                                    message: error.localizedDescription,
                                     buttonTitle: Constants.buttonAlertOk)
            self.viewController?.presentMFDialogOnMainThread(alert)
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
