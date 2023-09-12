//
//  GetMovieDetailUseCase.swift
//  MovieFlix
//
//  Created by Doni on 30/01/23.
//

import Foundation
import RxSwift

class GetMovieDetailUseCase {
    
    public typealias UseCaseEvent = Result<GetMovieDetailUseCaseResponse, MFError>
    private let service: ServiceProtocol
    
    public init(service: ServiceProtocol) {
        self.service = service
    }
    
}

extension GetMovieDetailUseCase: GetMovieDetailUseCaseProtocol {
    func execute(movieId: Int) -> Observable<Result<GetMovieDetailUseCaseResponse, MFError>> {
        let result = ReplaySubject<UseCaseEvent>.create()
        self.service.getMovieDetail(movieId: movieId) { serviceResult in
            result.onNext(serviceResult.mapError({ error in
                MFError.unableToComplete
            }))
        }
        return result
    }
    
}
