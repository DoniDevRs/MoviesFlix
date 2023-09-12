//
//  MFMovieIntroViewController.swift
//  MovieFlix
//
//  Created by Doni on 30/01/23.
//

import UIKit

public class MFMovieIntroViewController: UIViewController {
    
    // MARK: - PROPERTIES
    
    public let contentView: MFMovieIntroViewProtocol?
    
    // MARK: - PUBLIC API
    
    public weak var delegate: MFMovieIntroViewControllerDelegate?
    
    // MARK: - PUBLIC INITIALIZERS
    
    public init(contentView: MFMovieIntroViewProtocol = MFMovieIntroView()) {
        self.contentView = contentView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        if let contentView = contentView {
            self.view = contentView.content
        }
        contentView?.delegate = self
    }

}

extension MFMovieIntroViewController: MFMovieIntroViewDelegate {
    public func didTapButtonEnter() {
        delegate?.goToMovieHome()
    }
}
