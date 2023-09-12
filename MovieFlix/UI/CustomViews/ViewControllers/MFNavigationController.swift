//
//  MFNavigationController.swift
//  MovieFlix
//
//  Created by Doni on 13/03/23.
//

import UIKit

class MFNavigationController: UINavigationController {
    func defaultConfiguration() {
        setNavigationBarHidden(true, animated: false)
        navigationBar.prefersLargeTitles = false
        navigationItem.largeTitleDisplayMode = .never        
    }
}
