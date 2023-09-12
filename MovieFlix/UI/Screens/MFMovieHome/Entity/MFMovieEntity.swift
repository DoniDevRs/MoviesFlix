//
//  MFMovieEntity.swift
//  MovieFlix
//
//  Created by Doni on 30/01/23.
//

import UIKit

public struct MFMovieEntity: Codable, Hashable {
    public let id: Int
    public let title: String
    public let posterPath: String?
    public let releaseDate: String?
    public let voteCount: String?
    public let language: String?
    public let voteAverage: String
    public let backdropPath: String?
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
