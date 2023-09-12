//
//  DomainDIProtocol.swift
//  MovieFlix
//
//  Created by Doni on 31/01/23.
//

import Foundation

protocol DomainDIProtocol {
    func resolveGetListMoviesUseCase() -> GetListMoviesUseCaseProtocol
    func resolveGetMovieDetailUseCase() -> GetMovieDetailUseCaseProtocol
    func resolveGetMovieCreditsUseCase() -> GetMovieCreditsUseCaseProtocol
    func resolveGetMovieVideoUseCase() -> GetMovieVideoUseCaseProtocol
}
