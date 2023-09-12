//
//  MFMovieOverView.swift
//  MovieFlix
//
//  Created by Doni on 30/01/23.
//

import UIKit

public class MFMovieDetailOverView: UIView {
    
    enum Constans {
        static let titleSinopse = "titleSinopse".localized
        static let fontSize: CGFloat = 14
        static let sinopseFontSize: CGFloat = 20
    }
    
    // MARK: - UI
    
    private lazy var view: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        return view
    }()
    
    private lazy var sinopseLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: Constans.sinopseFontSize)
        label.text = Constans.titleSinopse
        return label
    }()
    
    private lazy var overViewLabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = .zero
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: Metrics.little)
       return label
    }()
    
    private lazy var stackCreditsInfo: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = Metrics.small
        stackView.distribution = .fill
        return stackView
    }()
    
    // MARK: - INITIALIZERS
    
    override public init(frame: CGRect) {
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
        view.addSubview(sinopseLabel)
        view.addSubview(overViewLabel)
        view.addSubview(stackCreditsInfo)
    }
    
    private func addConstraints() {
        view.constraintToSuperView()
        
        sinopseLabel.topTo(view.topAnchor)
        sinopseLabel.leadingTo(view.leadingAnchor, constant: Metrics.padding)
        sinopseLabel.trailingTo(view.trailingAnchor, constant: Metrics.padding)

        overViewLabel.topTo(sinopseLabel.bottomAnchor, constant: Metrics.little)
        overViewLabel.leadingTo(view.leadingAnchor, constant: Metrics.padding)
        overViewLabel.trailingTo(view.trailingAnchor, constant: Metrics.padding)

        stackCreditsInfo.topTo(overViewLabel.bottomAnchor, constant: Metrics.padding)
        stackCreditsInfo.leadingTo(leadingAnchor, constant: Metrics.padding)
        stackCreditsInfo.trailingTo(trailingAnchor, constant: Metrics.padding)
        stackCreditsInfo.bottomTo(view.bottomAnchor)
        
    }
    
    private func makeTitleWithSubtitleView() -> MFTitleWithSubtitleView {
        let titleWithSubtitle = MFTitleWithSubtitleView()
        titleWithSubtitle.translatesAutoresizingMaskIntoConstraints = false
        return titleWithSubtitle
    }
    
    private func makeStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }
    
    private func makeCastStackView(_ entity: MFMovieDetailEntity) {
        if entity.cast != nil && entity.cast!.count > 0 {
            let stackView = makeStackView()
            stackCreditsInfo.addArrangedSubview(stackView)
            
            entity.cast?.prefix(2).forEach({ cast in
                let titleWithSubtitleView = makeTitleWithSubtitleView()
                stackView.addArrangedSubview(titleWithSubtitleView)
                titleWithSubtitleView.updateCastView(with: cast)
                
            })
        }
    }
    
    private func makeCrewDirectorsProducersStackView(_ entity: MFMovieDetailEntity) {
        if entity.crew != nil && entity.crew!.count > 0 {
            let stackView = makeStackView()
            stackCreditsInfo.addArrangedSubview(stackView)
            
            if entity.directors != nil && entity.directors!.count > 0 {
                entity.directors?.prefix(1).forEach({ crew in
                    let titleWithSubtitleView = MFTitleWithSubtitleView()
                    titleWithSubtitleView.translatesAutoresizingMaskIntoConstraints = false
                    stackView.addArrangedSubview(titleWithSubtitleView)
                    titleWithSubtitleView.updateCrewView(with: crew)
                })
            }
            
            if entity.producers != nil && entity.producers!.count > 0 {
                entity.producers?.prefix(1).forEach({ crew in
                    let titleWithSubtitleView = MFTitleWithSubtitleView()
                    titleWithSubtitleView.translatesAutoresizingMaskIntoConstraints = false
                    stackView.addArrangedSubview(titleWithSubtitleView)
                    titleWithSubtitleView.updateCrewView(with: crew)
                })
            }
        }
    }
    
    private func makeCrewScreenWritersStackView(_ entity: MFMovieDetailEntity) {
        if entity.crew != nil && entity.crew!.count > 0 {
            let stackView = makeStackView()
            stackCreditsInfo.addArrangedSubview(stackView)
            
            if entity.screenWriters != nil && entity.screenWriters!.count > 0 {
                entity.screenWriters?.prefix(2).forEach({ crew in
                    let titleWithSubtitleView = MFTitleWithSubtitleView()
                    titleWithSubtitleView.translatesAutoresizingMaskIntoConstraints = false
                    stackView.addArrangedSubview(titleWithSubtitleView)
                    titleWithSubtitleView.updateCrewView(with: crew)
                })
            }
        }
    }
    
    
    public func updateView(_ movie: MFMovieDetailEntity) {
        DispatchQueue.main.async {
            self.overViewLabel.text = movie.overview
            self.makeCastStackView(movie)
            self.makeCrewDirectorsProducersStackView(movie)
            self.makeCrewScreenWritersStackView(movie)
        }
    }
}
