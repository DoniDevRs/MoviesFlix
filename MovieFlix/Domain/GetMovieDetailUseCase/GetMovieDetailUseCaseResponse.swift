//
//  GetMovieDetailUseCaseResponse.swift
//  MovieFlix
//
//  Created by Doni on 30/01/23.
//

import Foundation

public struct GetMovieDetailUseCaseResponse: Codable {
    public let title: String
    public let id: Int
    public let backdropPath: String
    public let overview: String
    public let originalLanguage: String
    public let originalTitle: String
    public let posterPath: String
    public let releaseDate: String
    public let runtime: Int
    public let voteAverage: Double
    public let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case title
        case id
        case backdropPath = "backdrop_path"
        case overview
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case runtime
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
