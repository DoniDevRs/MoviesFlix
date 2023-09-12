//
//  MFMovieHomeViewProtocol.swift
//  MovieFlix
//
//  Created by Doni on 31/01/23.
//

import UIKit

public protocol MFMovieHomeViewProtocol: AnyObject {
    var content: UIView { get }
    var delegate: MFMovieHomeViewDelegate? { get set }
    
    func updateView(with viewState: MFMovieHomeViewState)
}

extension MFMovieHomeViewProtocol where Self: UIView {
    public var content: UIView { return self }
}
