//
//  ServiceImplementation.swift
//  MovieFlix
//
//  Created by Doni on 30/01/23.
//

import Foundation

class ServiceImplementation {
    let operation: NetworkingOperationProtocol
    
    init(operation: NetworkingOperationProtocol) {
        self.operation = operation
    }
}

extension ServiceImplementation: ServiceProtocol {
    func getListMovies(from endpoint: String, completion: @escaping (Result<GetListMoviesUseCaseResponse, MFError>) -> Void) {
        let request = ServiceRequest.getListMovies(endPoint: endpoint)
        operation.execute(request: request, responseType: GetListMoviesUseCaseResponse.self) { result in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure:
                completion(.failure(.unableToComplete))
            }
        }
    }
    
    func getMovieDetail(movieId: Int, completion: @escaping (Result<GetMovieDetailUseCaseResponse, MFError>) -> Void) {
        let request = ServiceRequest.getMovieDetail(movieId: movieId)
        operation.execute(request: request, responseType: GetMovieDetailUseCaseResponse.self) { result in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure:
                completion(.failure(.unableToComplete))
            }
        }
    }
    
    func getMovieCredits(movieId: Int, completion: @escaping (Result<GetMovieCreditsUseCaseResponse, MFError>) -> Void) {
        let request = ServiceRequest.getMovieCredits(movieId: movieId)
        operation.execute(request: request, responseType: GetMovieCreditsUseCaseResponse.self) { result in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure:
                completion(.failure(.unableToComplete))
            }
        }
    }
    
    func getMovieVideo(movieId: Int, completion: @escaping (Result<GetMovieVideoUseCaseResponse, MFError>) -> Void) {
        let request = ServiceRequest.getMovieVideo(movieId: movieId)
        operation.execute(request: request, responseType: GetMovieVideoUseCaseResponse.self) { result in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure:
                completion(.failure(.unableToComplete))
            }
        }
    }
}
