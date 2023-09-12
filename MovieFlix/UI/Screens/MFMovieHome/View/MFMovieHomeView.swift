//
//  MFMovieHomeView.swift
//  MovieFlix
//
//  Created by Doni on 30/01/23.
//

import Foundation
import UIKit

public protocol MFMovieHomeViewDelegate: AnyObject {
    func goToDetail(_ movie: MFMovieEntity, view: MFMovieHomeView)
}

final public class MFMovieHomeView: UIView {

    enum Constants {
        static let itemPosterSize = CGSize(width: 204, height: 370)
        static let itemBackdropSize = CGSize(width: 272, height: 220)
    }
    
    // MARK: - UI
    
    private lazy var view: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        return view
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    private lazy var contentScrollView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .black
        return contentView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = Metrics.little
        stackView.backgroundColor = UIColor(hex: DarkColor.secondaryDark.rawValue)
        stackView.layer.cornerRadius = Metrics.tiny
        stackView.clipsToBounds = true
        return stackView
    }()

    
    private lazy var contentNowPlayingMovies: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    private lazy var nowPlayingListMovies: MFListMoviesPosterHomeView = {
        let contentView = MFListMoviesPosterHomeView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.delegate = self
        return contentView
    }()
    
    private lazy var contentUpComingMovies: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    private lazy var upComingMovies: MFListMoviesBackdropHomeView = {
        let contentView = MFListMoviesBackdropHomeView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.delegate = self
        return contentView
    }()
    
    private lazy var contentTopRatedMovies: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    private lazy var topRatedMovies: MFListMoviesBackdropHomeView = {
        let contentView = MFListMoviesBackdropHomeView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.delegate = self
        return contentView
    }()
    
    private lazy var contentPopularMovies: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    private lazy var popularMovies: MFListMoviesBackdropHomeView = {
        let contentView = MFListMoviesBackdropHomeView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.delegate = self
        return contentView
    }()
    
    private lazy var loadingView: MFLoadingView = {
        let loadingView = MFLoadingView()
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        return loadingView
    }()
    
    // MARK: - PUBLIC API
    
    public weak var delegate: MFMovieHomeViewDelegate?
    
    // MARK: - INITIALIZERS
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - PRIVATE
    
    private func setup() {
        buildViewHierarchy()
        addConstraints()
    }
    
    private func buildViewHierarchy() {
        addSubview(view)
        view.addSubview(scrollView)
        scrollView.addSubview(contentScrollView)
        contentScrollView.addSubview(stackView)
        
        stackView.addArrangedSubview(contentNowPlayingMovies)
        contentNowPlayingMovies.addSubview(nowPlayingListMovies)
        stackView.addArrangedSubview(contentUpComingMovies)
        contentUpComingMovies.addSubview(upComingMovies)
        stackView.addArrangedSubview(contentTopRatedMovies)
        contentTopRatedMovies.addSubview(topRatedMovies)
        stackView.addArrangedSubview(contentPopularMovies)
        contentPopularMovies.addSubview(popularMovies)
        view.addSubview(loadingView)
        
    }
    
    private func addConstraints() {
        view.constraintToSuperView()
        
        scrollView.constraintToSuperView()
        contentScrollView.constraintToSuperView(top: Metrics.padding)
        contentScrollView.width(widthAnchor)
        stackView.constraintToSuperView(leading: Metrics.medium, trailing: -Metrics.medium)
        
        nowPlayingListMovies.constraintToSuperView(leading: Metrics.padding, trailing: Metrics.padding)
        nowPlayingListMovies.height(Constants.itemPosterSize.height)
        
        upComingMovies.constraintToSuperView(leading: Metrics.padding, trailing: Metrics.padding)
        upComingMovies.height(Constants.itemBackdropSize.height)
        
        topRatedMovies.constraintToSuperView(leading: Metrics.padding, trailing: Metrics.padding)
        topRatedMovies.height(Constants.itemBackdropSize.height)
        
        popularMovies.constraintToSuperView(leading: Metrics.padding, trailing: Metrics.padding)
        popularMovies.height(Constants.itemBackdropSize.height)
        
        loadingView.constraintToSuperView()
        
    }
        
    private func updateNowPlayingMovies(with entity: [MFMovieEntity]) {
        nowPlayingListMovies.updateView(entity, title: MovieListEndPoint.nowPlaying.description)
    }
    
    private func updateUpComingMovies(with entity: [MFMovieEntity]) {
        upComingMovies.updateView(entity, title: MovieListEndPoint.upcoming.description)
    }
    
    private func updateTopRatedMovies(with entity: [MFMovieEntity]) {
        topRatedMovies.updateView(entity, title: MovieListEndPoint.topRated.description)
    }
    
    private func updatePopularMovies(with entity: [MFMovieEntity]) {
        popularMovies.updateView(entity, title: MovieListEndPoint.popular.description)
    }
    
    private func updateViewLoading(show: Bool) {
        DispatchQueue.main.async {
            self.loadingView.isHidden = !show
        }
    }
}

extension MFMovieHomeView: MFMovieHomeViewProtocol {
    public func updateView(with viewState: MFMovieHomeViewState) {
        switch viewState {
        case let .hasNowPlaying(data):
            updateNowPlayingMovies(with: data)
        case let .hasUpcoming(data):
            updateUpComingMovies(with: data)
        case let .hasTopRated(data):
            updateTopRatedMovies(with: data)
        case let .hasPopular(data):
            updatePopularMovies(with: data)
        case let .isLoading(show):
            updateViewLoading(show: show)
        case .isEmpty:
            break
        }
    }
}

extension MFMovieHomeView: MFListMoviesPosterHomeViewDelegate {
    public func goToDetail(movie: MFMovieEntity) {
        delegate?.goToDetail(movie, view: self)
    }
}

extension MFMovieHomeView: MFListMoviesBackdropHomeViewDelegate {
    public func goToBackdropDetail(movie: MFMovieEntity) {
        delegate?.goToDetail(movie, view: self)
    }
}
