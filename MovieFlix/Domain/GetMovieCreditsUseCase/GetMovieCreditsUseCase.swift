//
//  GetMovieCreditsUseCase.swift
//  MovieFlix
//
//  Created by Doni on 22/02/23.
//

import Foundation
import RxSwift

class GetMovieCreditsUseCase {
    
    public typealias UseCaseEvent = Result<GetMovieCreditsUseCaseResponse, MFError>
    private let service: ServiceProtocol
    
    public init(service: ServiceProtocol) {
        self.service = service
    }
    
}

extension GetMovieCreditsUseCase: GetMovieCreditsUseCaseProtocol {
    func execute(movieId: Int) -> Observable<Result<GetMovieCreditsUseCaseResponse, MFError>> {
        let result = ReplaySubject<UseCaseEvent>.create()
        self.service.getMovieCredits(movieId: movieId) { serviceResult in
            result.onNext(serviceResult.mapError({ error in
                MFError.unableToComplete
            }))
        }
        return result
        
    }
}
