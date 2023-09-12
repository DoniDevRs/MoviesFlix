//
//  MFMovieHomeViewState.swift
//  MovieFlix
//
//  Created by Doni on 30/01/23.
//

public enum MFMovieHomeViewState {
    case hasNowPlaying([MFMovieEntity])
    case hasUpcoming([MFMovieEntity])
    case hasTopRated([MFMovieEntity])
    case hasPopular([MFMovieEntity])
    case isLoading(Bool)
    case isEmpty
}
