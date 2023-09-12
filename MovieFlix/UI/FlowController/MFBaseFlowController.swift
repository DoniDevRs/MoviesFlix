//
//  MFBaseFlowController.swift
//  MovieFlix
//
//  Created by Doni on 31/01/23.
//

import UIKit

class MFBaseFlowController {
    
    private var flowNavigation: UINavigationController
    private let tabBarMenu: UITabBarController = UITabBarController()
    private var tabs: [UIViewController] = []
    private let factory: MFFactoryProtocol
        
    init(flowNavigation: UINavigationController,
         factory: MFFactoryProtocol) {
        self.flowNavigation = flowNavigation
        self.factory = factory
    }
    
    public func rootViewController() -> UINavigationController? {
        let viewController = makeTabBarViewControllers()
        flowNavigation.pushViewController(viewController, animated: true)
        return flowNavigation
    }
    
    private func makeTabBarViewControllers() -> UITabBarController {
        tabs = [
            makeMFIntroViewController(),
            makeMFMovieFavoritesViewController()
        ]
        tabBarMenu.setViewControllers(tabs, animated: true)
        UITabBar.appearance().tintColor = .systemOrange
        return tabBarMenu
    }
    
    private func makeMFIntroViewController() -> UIViewController {
        let introVC = MFMovieIntroViewController()
        introVC.delegate = self
        introVC.tabBarItem = UITabBarItem(title: "titleTabBar".localized, image: UIImage(systemName: "tv"), tag: 0)
        return introVC
    }
    
    private func makeMFMovieFavoritesViewController() -> UIViewController {
        let viewModel = MFMovieFavoritesViewModel()
        let favoritesVC = MFMovieFavoritesViewController(viewModel: viewModel)
        favoritesVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        viewModel.viewController = favoritesVC
        favoritesVC.delegate = self
        return UINavigationController(rootViewController: favoritesVC)
    }

}

extension MFBaseFlowController: MFMovieIntroViewControllerDelegate {
    func goToMovieHome() {
        let viewController = factory.makeMFHomeViewController()
        viewController.delegate = self
        flowNavigation.pushViewController(viewController, animated: true)
    }
}

extension MFBaseFlowController: MFMovieHomeViewControllerDelegate {
    func goToMovieDetail(movieId: Int) {
        let viewController = factory.makeMFMovieDetailViewController(movieId: movieId)
        flowNavigation.pushViewController(viewController, animated: true)
    }
}

extension MFBaseFlowController: MFMovieFavoritesViewControllerDelegate {
    func goToMovieDetail(entity: MFMovieEntity) {
        let viewController = factory.makeMFMovieDetailViewController(movieId: entity.id)
        flowNavigation.pushViewController(viewController, animated: true)
    }
}
