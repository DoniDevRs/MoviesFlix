//
//  MFMovieDetailProtocol.swift
//  MovieFlix
//
//  Created by Doni on 30/01/23.
//

import UIKit

public protocol MFMovieDetailProtocol: AnyObject {
    var content: UIView { get }
    var delegate: MFMovieDetailViewDelegate? { get set }
    
    func updateView(with viewState: MFMovieDetailViewState)
}

extension MFMovieDetailProtocol where Self: UIView {
    public var content: UIView { return self }
}
