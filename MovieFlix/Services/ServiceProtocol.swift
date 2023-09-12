//
//  ServiceProtocol.swift
//  MovieFlix
//
//  Created by Doni on 30/01/23.
//

import Foundation

protocol ServiceProtocol {
    func getListMovies(from endpoint: String, completion: @escaping (Result<GetListMoviesUseCaseResponse, MFError>) -> Void)
    func getMovieDetail(movieId: Int, completion: @escaping (Result<GetMovieDetailUseCaseResponse, MFError>) -> Void)
    func getMovieCredits(movieId: Int, completion: @escaping (Result<GetMovieCreditsUseCaseResponse, MFError>) -> Void)
    func getMovieVideo(movieId: Int, completion: @escaping (Result<GetMovieVideoUseCaseResponse, MFError>) -> Void)
}
