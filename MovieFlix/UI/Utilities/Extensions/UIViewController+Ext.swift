//
//  UIViewController+Ext.swift
//  MovieFlix
//
//  Created by Doni on 27/02/23.
//

import UIKit
import SafariServices

extension UIViewController {
    
    public func presentMFDialogOnMainThread(_ dialogEntity: DialogEntity) {
        DispatchQueue.main.async {
            let dialogVC = MFDialogViewController(dialogEntity)
            dialogVC.modalPresentationStyle = .overFullScreen
            dialogVC.modalTransitionStyle = .crossDissolve
            self.present(dialogVC, animated: true)
        }
    }
    
    public func presentSafariVC(with url: URL) {
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .systemGreen
        present(safariVC, animated: true)
    }
    
    public func showEmptyStateView(with message: String) {
        DispatchQueue.main.async {
            let emptyStateView = MFEmptyStateView(message: message)
            emptyStateView.frame = self.view.bounds
            self.view.addSubview(emptyStateView)
        }
    }
    
    func configureNavigationBar(largeTitleColor: UIColor, backgoundColor: UIColor, tintColor: UIColor, title: String, preferredLargeTitle: Bool) {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithTransparentBackground()
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: largeTitleColor]
        navBarAppearance.titleTextAttributes = [.foregroundColor: largeTitleColor]
        navBarAppearance.backgroundColor = backgoundColor
        
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.compactAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        
        navigationController?.navigationBar.prefersLargeTitles = preferredLargeTitle
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = tintColor
        navigationItem.title = title
    }
}


