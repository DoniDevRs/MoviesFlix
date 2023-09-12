//
//  GetMovieCreditsUseCaseProtocol.swift
//  MovieFlix
//
//  Created by Doni on 22/02/23.
//

import Foundation
import RxSwift

public protocol GetMovieCreditsUseCaseProtocol: AnyObject {
    func execute(movieId: Int) -> Observable<Result<GetMovieCreditsUseCaseResponse, MFError>>
}
