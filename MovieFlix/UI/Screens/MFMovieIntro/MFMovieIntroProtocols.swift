//
//  MFMovieIntroProtocols.swift
//  MovieFlix
//
//  Created by Doni on 31/01/23.
//

import Foundation

public protocol MFMovieIntroViewControllerProtocol: AnyObject {
    var contentView: MFMovieIntroViewProtocol? { get }
}

public protocol MFMovieIntroViewControllerDelegate: AnyObject {
    func goToMovieHome()
}
