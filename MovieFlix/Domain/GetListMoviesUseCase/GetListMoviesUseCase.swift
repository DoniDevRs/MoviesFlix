//
//  GetListMoviesUseCase.swift
//  MovieFlix
//
//  Created by Doni on 08/03/23.
//

import Foundation
import RxSwift

class GetListMoviesUseCase {
    
    public typealias UseCaseEvent = Result<GetListMoviesUseCaseResponse, MFError>
    private let service: ServiceProtocol
    
    public init(service: ServiceProtocol) {
        self.service = service
    }
}

extension GetListMoviesUseCase: GetListMoviesUseCaseProtocol {
    func execute(from endpoint: String) -> Observable<UseCaseEvent> {
        let result = ReplaySubject<UseCaseEvent>.create()
        self.service.getListMovies(from: endpoint) { serviceResult in
            result.onNext(serviceResult.mapError { error in
                MFError.unableToComplete
            })
        }
        return result
    }
}
