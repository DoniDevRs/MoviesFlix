//
//  MFMovieHomeViewController.swift
//  MovieFlix
//
//  Created by Doni on 30/01/23.
//

import Foundation
import UIKit

public class MFMovieHomeViewController: UIViewController {
    
    enum Constants {
        static let title = "Movies Flix"
        static let leftNavImage = "arrow"
    }
    
    // MARK: - PROPERTIES
    
    public let contentView: MFMovieHomeViewProtocol?
    public let viewModel: MFMovieHomeViewModelProtocol?
    
    // MARK: - PUBLIC API
    
    public weak var delegate: MFMovieHomeViewControllerDelegate?
    
    // MARK: - PUBLIC INITIALIZERS
    
    public init(contentView: MFMovieHomeViewProtocol = MFMovieHomeView(), viewModel: MFMovieHomeViewModelProtocol) {
        self.contentView = contentView
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupNavigationBarItens()
        viewModel?.initState()
        
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar(largeTitleColor: .white, backgoundColor: .black, tintColor: .white, title: Constants.title, preferredLargeTitle: true)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    private func setup() {
        if let contentView = contentView {
            self.view = contentView.content
        }
        contentView?.delegate = self
    }
    
    public func setupNavigationBarItens() {
        setupLeftNavItem()
    }
    
    private func setupLeftNavItem() {
        let arrowButton = UIButton(type: .system)
        arrowButton.setImage(UIImage(named: Constants.leftNavImage), for: .normal)
        arrowButton.frame = CGRect(x: .zero, y: .zero, width: Metrics.padding, height: Metrics.padding)
        arrowButton.tintColor = .white
        arrowButton.addTarget(self, action: #selector(popVC), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: arrowButton)
    }
    
    @objc private func popVC() {
        navigationController?.popViewController(animated: true)
    }
}

extension MFMovieHomeViewController: MFMovieHomeViewControllerProtocol {
    public func updateView(with viewState: MFMovieHomeViewState) {
        contentView?.updateView(with: viewState)
    }
    
    public func showDialog(with dialog: DialogEntity) {
        presentMFDialogOnMainThread(dialog)
    }
}

extension MFMovieHomeViewController: MFMovieHomeViewDelegate {
    public func goToDetail(_ movie: MFMovieEntity, view: MFMovieHomeView) {
        delegate?.goToMovieDetail(movieId: movie.id)
    }
}
