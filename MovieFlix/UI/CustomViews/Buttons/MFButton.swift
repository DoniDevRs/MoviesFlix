//
//  MFButton.swift
//  MovieFlix
//
//  Created by Doni on 31/01/23.
//

import UIKit

public class MFButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(color: UIColor, title: String, font: UIFont) {
        self.init(frame: .zero)
        set(color: color, title: title, font: font)
    }
    
    private func configure() {
        configuration = .filled()
        translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    public func set(color: UIColor, title: String, font: UIFont) {
        DispatchQueue.main.async {
            self.configuration?.baseBackgroundColor = color
            self.configuration?.title = title
            self.titleLabel?.font = font
        }
    }
}
