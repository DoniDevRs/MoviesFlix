//
//  GetListMoviesUseCaseProtocol.swift
//  MovieFlix
//
//  Created by Doni on 08/03/23.
//

import Foundation
import RxSwift

public protocol GetListMoviesUseCaseProtocol: AnyObject {
    func execute(from endpoint: String) -> Observable<Result<GetListMoviesUseCaseResponse, MFError>>
}
