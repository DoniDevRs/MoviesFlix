//
//  MFMovieHomeFactoryEntity.swift
//  MovieFlix
//
//  Created by Doni on 10/02/23.
//

import Foundation
 
public struct MFMovieHomeFactoryEntity {
    
    private let data: GetListMoviesUseCaseResponse
    
    public init(data: GetListMoviesUseCaseResponse) {
        self.data = data
    }
    
    public func makeListMoviesEntity() -> [MFMovieEntity] {
        let movies = data.results?.map {
            MFMovieEntity(id: $0.id,
                       title: $0.title,
                        posterPath: $0.posterPath,
                        releaseDate: $0.releaseDate,
                        voteCount: String($0.voteCount),
                        language: $0.originalLanguage,
                        voteAverage: String($0.voteAverage),
                        backdropPath: $0.backdropPath
            )
            
        } ?? []
        return movies
    }
}
