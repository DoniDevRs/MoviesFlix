//
//  MFMovieDetailViewController.swift
//  MovieFlix
//
//  Created by Doni on 30/01/23.
//

import UIKit
import SafariServices

public class MFMovieDetailViewController: UIViewController {

    // MARK: - PROPERTIES
    
    public let contentView: MFMovieDetailProtocol?
    public let viewModel: MFMovieDetailViewModelProtocol?
    
    // MARK: - PUBLIC API
    
    public weak var delegate: MFMovieDetailViewControllerDelegate?
    
    // MARK: PUBLIC INITIALIZERS
    
    public init(contentView: MFMovieDetailProtocol = MFMovieDetailView(), viewModel: MFMovieDetailViewModelProtocol) {
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
        configureNavigationBar(largeTitleColor: .white, backgoundColor: .clear, tintColor: .clear, title: "", preferredLargeTitle: false)
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
    
}

extension MFMovieDetailViewController: MFMovieDetailViewControllerProtocol {    
    public func updateView(with viewState: MFMovieDetailViewState) {
        contentView?.updateView(with: viewState)
    }
    
    public func showDialog(with dialog: DialogEntity) {
        presentMFDialogOnMainThread(dialog)
    }
}

extension MFMovieDetailViewController: MFMovieDetailViewDelegate {
    public func didTapButtonWatchTrailer() {
        viewModel?.getMovieVideo()
    }
}
