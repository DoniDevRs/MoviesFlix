//
//  MFFactoryProtocol.swift
//  MovieFlix
//
//  Created by Doni on 31/01/23.
//

import Foundation

public protocol MFFactoryProtocol {
    func makeMFHomeViewController() -> MFMovieHomeViewController
    func makeMFMovieDetailViewController(movieId: Int) -> MFMovieDetailViewController
}
