//
//  GetMovieVideoUseCase.swift
//  MovieFlix
//
//  Created by Doni on 25/02/23.
//

import Foundation
import RxSwift

class GetMovieVideoUseCase {
    
    public typealias UseCaseEvent = Result<GetMovieVideoUseCaseResponse, MFError>
    private let service: ServiceProtocol
    
    public init(service: ServiceProtocol) {
        self.service = service
    }
    
}

extension GetMovieVideoUseCase: GetMovieVideoUseCaseProtocol {
    func execute(movieId: Int) -> Observable<Result<GetMovieVideoUseCaseResponse, MFError>> {
        let result = ReplaySubject<UseCaseEvent>.create()
        self.service.getMovieVideo(movieId: movieId) { serviceResult in
            result.onNext(serviceResult.mapError({ error in
                MFError.unableToComplete
            }))
        }
        return result
    }

}
