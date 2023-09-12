//
//  MFMovieDetailState.swift
//  MovieFlix
//
//  Created by Doni on 30/01/23.
//

import Foundation

public enum MFMovieDetailViewState {
    case hasData(MFMovieDetailEntity)
    case isLoading(Bool)
    case isEmpty
}
