//
//  GetMovieDetailUseCaseProtocol.swift
//  MovieFlix
//
//  Created by Doni on 30/01/23.
//

import Foundation
import RxSwift

public protocol GetMovieDetailUseCaseProtocol: AnyObject {
    func execute(movieId: Int) -> Observable<Result<GetMovieDetailUseCaseResponse, MFError>>

}
