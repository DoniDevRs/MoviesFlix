//
//  MFMovieIntroViewProtocol.swift
//  MovieFlix
//
//  Created by Doni on 31/01/23.
//

import UIKit

public protocol MFMovieIntroViewProtocol: AnyObject {
    var content: UIView { get }
    var delegate: MFMovieIntroViewDelegate? { get set }
}

public protocol MFMovieIntroViewDelegate: AnyObject {
    func didTapButtonEnter()
}

extension MFMovieIntroViewProtocol where Self: UIView {
    public var content: UIView { return self }
}
