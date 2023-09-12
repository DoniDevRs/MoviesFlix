//
//  GetListMoviesUseCaseResponse.swift
//  MovieFlix
//
//  Created by Doni on 08/03/23.
//

import Foundation

public struct GetListMoviesUseCaseResponse: Codable {
    public let page: Int
    public let results: [MovieResponse]?
}

public struct MovieResponse: Codable {
    public let id: Int
    public let title: String
    public let backdropPath: String?
    public let posterPath: String?
    public let overview: String
    public let voteAverage: Double
    public let genreIDS: [Int]
    public let originalTitle: String
    public let originalLanguage: String
    public let popularity: Double
    public let releaseDate: String
    public let video: Bool
    public let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalTitle = "original_title"
        case originalLanguage = "original_language"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
