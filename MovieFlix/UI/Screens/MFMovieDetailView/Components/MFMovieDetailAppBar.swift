//
//  MFMovieDetailAppBar.swift
//  MovieFlix
//
//  Created by Doni on 30/01/23.
//

import UIKit

extension MFMovieDetailViewController {
    
    func setupNavigationBarItens() {
        setupLeftNavItens()
        setupRightNavItens()
    }
    
    private func setupLeftNavItens() {
        let arrowButton = UIButton(type: .system)
        arrowButton.setImage(Images.leftNavImage, for: .normal)
        arrowButton.frame = CGRect(x: .zero, y: .zero, width: Metrics.padding, height: Metrics.padding)
        arrowButton.tintColor = .white
        arrowButton.addTarget(self, action: #selector(popVc), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: arrowButton)
    }
    
    private func setupRightNavItens() {
        updateButtonFav(false)
    }
    
    @objc private func popVc() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func likeMovie() {
        viewModel?.likeMovieTapped()
        updateButtonFav(true)

    }
    
    private func updateButtonFav(_ isFavorited: Bool) {
        let bubbleButton = UIButton(type: .system)
        bubbleButton.setImage(Images.liked, for: .normal)
        bubbleButton.frame = CGRect(x: .zero, y: .zero, width: Metrics.padding, height: Metrics.padding)
        bubbleButton.tintColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: bubbleButton)
        bubbleButton.addTarget(self, action: #selector(likeMovie), for: .touchUpInside)
        
        let image: UIImage = isFavorited ? Images.liked : Images.like
        bubbleButton.setImage(image, for: .normal)
        
    }
}
