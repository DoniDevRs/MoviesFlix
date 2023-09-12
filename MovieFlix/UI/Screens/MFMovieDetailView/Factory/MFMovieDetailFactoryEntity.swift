//
//  MFMovieDetailFactory.swift
//  MovieFlix
//
//  Created by Doni on 17/02/23.
//

import Foundation

public struct MFMovieDetailFactoryEntity {
    
    private let data: GetMovieDetailUseCaseResponse
    private let creditsData: GetMovieCreditsUseCaseResponse
    
    public init(data: GetMovieDetailUseCaseResponse, creditsData: GetMovieCreditsUseCaseResponse) {
        self.data = data
        self.creditsData = creditsData
    }
    
    public func make() -> MFMovieDetailEntity {
        MFMovieDetailEntity(id: data.id,
                            title: data.title,
                            backdropPath: data.backdropPath,
                            overview: data.overview,
                            runtime: data.runtime,
                            releaseDate: data.releaseDate,
                            credits: makeMovieCredit(creditsData))
        
    }
    
    private func makeMovieCredit(_ creditsData: GetMovieCreditsUseCaseResponse) -> MovieCredit {
        return MovieCredit(id: creditsData.id,
                           cast: makeMovieCast(creditsData),
                          crew: makeMovieCrew(creditsData))
    }
    
    private func makeMovieCast(_ creditsData: GetMovieCreditsUseCaseResponse) -> [MovieCastEntity] {
        let movieCast = creditsData.cast.map { MovieCastEntity(character: $0.character,
                                                                  name: $0.name)
        }
        return movieCast
    }
    
    private func makeMovieCrew(_ creditsData: GetMovieCreditsUseCaseResponse) -> [MovieCrewEntity] {
        let movieCrew = creditsData.crew.map { MovieCrewEntity(job: $0.job,
                                                                  name: $0.name)
        }
        return movieCrew
    }
    
}
