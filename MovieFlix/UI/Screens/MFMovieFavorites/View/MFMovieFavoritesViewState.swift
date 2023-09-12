//
//  MFMovieFavoritesViewState.swift
//  MovieFlix
//
//  Created by Doni on 27/02/23.
//

public enum MFMovieFavoritesViewState {
    case hasData([MFMovieEntity])
    case isLoading(Bool)
    case isEmpty
}
