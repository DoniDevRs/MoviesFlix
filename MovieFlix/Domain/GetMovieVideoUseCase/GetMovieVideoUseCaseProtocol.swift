//
//  GetMovieVideoUseCaseProtocol.swift
//  MovieFlix
//
//  Created by Doni on 25/02/23.
//

import Foundation
import RxSwift

public protocol GetMovieVideoUseCaseProtocol: AnyObject {
    func execute(movieId: Int) -> Observable<Result<GetMovieVideoUseCaseResponse, MFError>>
}
