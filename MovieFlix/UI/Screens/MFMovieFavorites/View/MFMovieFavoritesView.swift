//
//  MFMovieFavoritesView.swift
//  MovieFlix
//
//  Created by Doni on 27/02/23.
//

import UIKit

final public class MFMovieFavoritesView: UIView {
    
    enum Constants {
        static let rowHeight: CGFloat = 148
        static let emptyFavoritesMessage = "emptyFavoritesMessage".localized
    }
    
    // MARK: - UI
    
    private lazy var view: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .black
        tableView.invalidateIntrinsicContentSize()
        tableView.rowHeight = Constants.rowHeight
        tableView.delegate = tableViewDataSource
        tableView.dataSource = tableViewDataSource
        tableView.removeExcessCells()
        tableView.register(MFMovieFavoriteCell.self, forCellReuseIdentifier: MFMovieFavoriteCell.Constants.reuseID)
        return tableView
    }()
    
    private lazy var loadingView: MFLoadingView = {
        let loadingView = MFLoadingView()
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        return loadingView
    }()

    private lazy var emptyView: MFEmptyStateView = {
        let emptyView = MFEmptyStateView(message: Constants.emptyFavoritesMessage)
        emptyView.translatesAutoresizingMaskIntoConstraints = false
        emptyView.isHidden = true
        return emptyView
    }()
    
    // MARK: - PUBLIC API
     
    public weak var delegate: MFMovieFavoritesViewDelegate?
    
    private lazy var tableViewDataSource: MFMovieFavoritesListViewDataSource = {
        return MFMovieFavoritesListViewDataSource(favorites: [], delegate: self)
    }()
    
    // MARK: - INITIALIZERS
    
    override public init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - PRIVATE
    
    private func setup() {
        buildViewHierachy()
        addConstraints()
    }
    
    private func buildViewHierachy() {
        addSubview(view)
        view.addSubview(tableView)
        view.addSubview(loadingView)
        view.addSubview(emptyView)
    }
    
    private func addConstraints() {
        view.constraintToSuperView()
        tableView.constraintToSuperView()
        loadingView.constraintToSuperView()
        emptyView.constraintToSuperView()
    }
    
    private func updateViewLoading(show: Bool) {
        DispatchQueue.main.async {
            self.loadingView.isHidden = !show
        }
    }
    
    public func updateView(with favorites: [MFMovieEntity]) {
        if favorites.isEmpty {
            emptyView.isHidden = false
        } else {
            emptyView.isHidden = true
            tableViewDataSource.update(with: favorites)
            tableView.reloadDataOnMainThread()
        }
    }
}

extension MFMovieFavoritesView: MFMovieFavoritesListViewDataSourceDelegate {
    public func didSelectItem(with entity: MFMovieEntity) {
        delegate?.goToMovieDetail(entity: entity)
        
    }
    
    public func showRemoveError(with dialog: DialogEntity) {
        delegate?.showRemoveError(with: dialog)
    }
}

extension MFMovieFavoritesView: MFMovieFavoritesViewProtocol {
    public func updateView(with viewState: MFMovieFavoritesViewState) {
        switch viewState {
        case let .hasData(data):
            updateView(with: data)
        case let .isLoading(show):
            updateViewLoading(show: show)
        case .isEmpty:
            break
        }
    }
}
