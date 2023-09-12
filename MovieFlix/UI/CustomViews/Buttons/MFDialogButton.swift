//
//  MFDialogButton.swift
//  MovieFlix
//
//  Created by Doni on 27/02/23.
//

import UIKit

public class MFDialogButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(color: UIColor, title: String, systemImageName: String) {
        self.init(frame: .zero)
        set(color: color, title: title, systemImageName: systemImageName)
    }
    
    private func configure() {
        configuration = .tinted()
        configuration?.cornerStyle = .medium
        translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    public func set(color: UIColor, title: String, systemImageName: String) {
        DispatchQueue.main.async {
            self.configuration?.baseBackgroundColor = color
            self.configuration?.baseForegroundColor = color
            self.configuration?.title = title
            
            self.configuration?.image = UIImage(systemName: systemImageName)
            self.configuration?.imagePadding = 6
            self.configuration?.imagePlacement = .leading
        }
    }
}
