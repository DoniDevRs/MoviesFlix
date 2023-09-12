//
//  DomainDI.swift
//  MovieFlix
//
//  Created by Doni on 31/01/23.
//

import Foundation

class DomainDI {
    let service: ServiceProtocol
    
    init(service: ServiceProtocol) {
        self.service = service
    }
}

extension DomainDI: DomainDIProtocol {
    func resolveGetListMoviesUseCase() -> GetListMoviesUseCaseProtocol {
        return GetListMoviesUseCase(service: service)
    }
    
    func resolveGetMovieDetailUseCase() -> GetMovieDetailUseCaseProtocol {
        return GetMovieDetailUseCase(service: service)
    }
    
    func resolveGetMovieCreditsUseCase() -> GetMovieCreditsUseCaseProtocol {
        return GetMovieCreditsUseCase(service: service)
    }
    
    func resolveGetMovieVideoUseCase() -> GetMovieVideoUseCaseProtocol {
        return GetMovieVideoUseCase(service: service)
    }
}
