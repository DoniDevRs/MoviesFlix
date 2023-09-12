//
//  Enums.swift
//  MovieFlix
//
//  Created by Doni on 09/03/23.
//

import UIKit

public enum MovieListEndPoint: String, CaseIterable {
    case nowPlaying = "now_playing"
    case upcoming
    case topRated = "top_rated"
    case popular
    
    var description: String {
        switch self {
        case .nowPlaying: return "nowPlayingText".localized
        case .upcoming: return "upComingText".localized
        case .topRated: return "topRatedText".localized
        case .popular: return "popularText".localized
        }
    }
}

public enum DarkColor: String {
    case primaryDark = "#000000"
    case secondaryDark = "#1C1C1E"
}

public enum Images {
    static let logoIntro = UIImage(named: "movies")
    static let emptyMovieState = UIImage(named: "empty-movie-state")
    static let like = UIImage(named: "like")!
    static let liked = UIImage(named: "liked")!
    static let leftNavImage = UIImage(named: "arrow")
}
