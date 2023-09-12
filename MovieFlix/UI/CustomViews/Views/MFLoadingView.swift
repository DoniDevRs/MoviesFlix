//
//  MFLoadingView.swift
//  MovieFlix
//
//  Created by Doni on 13/03/23.
//

import UIKit

public final class MFLoadingView: UIView {
    
    // MARK: UI
    
    private lazy var view: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
       return view
    }()
    
    private lazy var indicatorView: UIActivityIndicatorView = {
        let indicatorView = UIActivityIndicatorView(style: .large)
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
       return indicatorView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        buildViewHierarchy()
        addConstraints()
        configureView()
    }
    
    private func buildViewHierarchy() {
        addSubview(view)
        view.addSubview(indicatorView)
    }
    
    private func addConstraints() {
        view.constraintToSuperView()
        indicatorView.centerYTo(view.centerYAnchor)
        indicatorView.centerXTo(view.centerXAnchor)
    }
    
    private func configureView() {
        view.backgroundColor = .systemBackground
        view.alpha = .zero
        
        UIView.animate(withDuration: 0.25) { self.view.alpha = 0.8 }
        indicatorView.startAnimating()
    }
}

