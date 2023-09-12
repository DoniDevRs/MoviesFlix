//
//  MFError.swift
//  MovieFlix
//
//  Created by Doni on 30/01/23.
//

import Foundation

public enum MFError:  Error {
    case unableToComplete
    case invalidResponse
    case invalidData
    case unableToFavorite
    case alreadyInFavorites
    case invalidURL
    
    var localizedDescription: String {
        switch self {
        case .unableToComplete:
            return "unableToComplete".localized
        case .invalidResponse:
            return "invalidResponse".localized
        case .invalidData:
            return "invalidData".localized
        case .unableToFavorite:
            return "unableToFavorite".localized
        case .alreadyInFavorites:
            return "alreadyInFavorites".localized
        case .invalidURL:
            return "invalidURL".localized
        }
    }
    
}
