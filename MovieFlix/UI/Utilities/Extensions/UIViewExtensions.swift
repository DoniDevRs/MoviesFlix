//
//  UIViewExtensions.swift
//  MovieFlix
//
//  Created by Doni on 31/01/23.
//

import UIKit

public protocol LayoutGuideProvider {
    var leadingAnchor: NSLayoutXAxisAnchor { get }
    var trailingAnchor: NSLayoutXAxisAnchor { get }
    var leftAnchor: NSLayoutXAxisAnchor { get }
    var rightAnchor: NSLayoutXAxisAnchor { get }
    var topAnchor: NSLayoutYAxisAnchor { get }
    var bottomAnchor: NSLayoutYAxisAnchor { get }
    var widthAnchor: NSLayoutDimension { get }
    var heightAnchor: NSLayoutDimension { get }
    var centerXAnchor: NSLayoutXAxisAnchor { get }
    var centerYAnchor: NSLayoutYAxisAnchor { get }
}

extension UIView: LayoutGuideProvider { }
extension UILayoutGuide: LayoutGuideProvider { }

extension UIView {
    
    // MARK: - EXTENSION FUNCTIONS
    
    /// Constraints to its superview
    ///
    ///  - Parameters:
    ///     - top: Top constant. Default value is 0
    ///     - leading: Leading constant. Default value is 0.
    ///     - trailing: Trailing constant. Default value is 0.
    ///     - bottom:  Bottom constant. Default value is 0.
    
    public func constraintToSuperView(top: CGFloat = 0,
                                      leading: CGFloat = 0,
                                      trailing: CGFloat = 0,
                                      bottom: CGFloat = 0,
                                      bottomPriority: UILayoutPriority = .required,
                                      respectSafeArea: Bool = false) {
        guard let superview = superview else {
            return
        }
        
        let layoutGuideProvider: LayoutGuideProvider = respectSafeArea ? superview.safeAreaLayoutGuide : superview
        
        let bottomConstraint = bottomAnchor.constraint(equalTo: layoutGuideProvider.bottomAnchor, constant: bottom)
        
        let constraints = [
            topAnchor.constraint(equalTo: layoutGuideProvider.topAnchor, constant: top),
            trailingAnchor.constraint(equalTo: layoutGuideProvider.trailingAnchor, constant: trailing),
            leadingAnchor.constraint(equalTo: layoutGuideProvider.leadingAnchor, constant: leading),
            bottomConstraint
        ]
        
        bottomConstraint.priority = bottomPriority
        NSLayoutConstraint.activate(constraints)
    }
    
    /// Constraint height and width based its parameters
    ///
    ///  - Parameters:
    ///   - height: Height constant
    ///   - width: Width constant
    
    public func constraint(height: CGFloat, width: CGFloat) {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: height),
            widthAnchor.constraint(equalToConstant: width)
        ])
    }
    
    public func contraintToCenter(from view: UIView) {
        NSLayoutConstraint.activate([
            centerXAnchor.constraint(equalTo: view.centerXAnchor),
            centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    public func constraintToSuperviewVerticalCenter(height: CGFloat? = nil) {
        guard let superview = self.superview else {
            return
        }
        if let height = height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        NSLayoutConstraint.activate([
            topAnchor.constraint(greaterThanOrEqualTo: superview.topAnchor),
            bottomAnchor.constraint(lessThanOrEqualTo: superview.bottomAnchor),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor),
            leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            centerYAnchor.constraint(equalTo: superview.centerYAnchor)
        ])
    }
    
    public func constraintToSuperviewHorizontalCenter(width: CGFloat? = nil) {
        guard let superview = self.superview else {
            return
        }
        if let width = width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.topAnchor),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor),
            trailingAnchor.constraint(greaterThanOrEqualTo: superview.trailingAnchor),
            leadingAnchor.constraint(lessThanOrEqualTo: superview.leadingAnchor),
            centerXAnchor.constraint(equalTo: superview.centerXAnchor)
        ])
    }
    
    @discardableResult
    public func topTo(_ anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0, priority: UILayoutPriority = .required) -> UIView {
        let top = topAnchor.constraint(equalTo: anchor, constant: constant)
        top.priority = priority
        top.isActive = true
        return self
    }
    
    @discardableResult
    public func topToGreather(_ anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0) -> UIView {
        topAnchor.constraint(greaterThanOrEqualTo: anchor, constant: constant).isActive = true
        return self
    }
    
    @discardableResult
    public func topToLess(_ anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0) -> UIView {
        topAnchor.constraint(lessThanOrEqualTo: anchor, constant: constant).isActive = true
        return self
    }
    
    @discardableResult
    public func bottomTo(_ anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0, priority: UILayoutPriority = .required) -> UIView {
        let bottom = bottomAnchor.constraint(equalTo: anchor, constant: -constant)
        bottom.priority = priority
        bottom.isActive = true
        return self
    }
    
    @discardableResult
    public func bottomToGreather(_ anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0) -> UIView {
        bottomAnchor.constraint(greaterThanOrEqualTo: anchor, constant: -constant).isActive = true
        return self
    }
    
    @discardableResult
    public func bottomToLess(_ anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0) -> UIView {
        bottomAnchor.constraint(lessThanOrEqualTo: anchor, constant: -constant).isActive = true
        return self
    }
    
    @discardableResult
    public func leadingTo(_ anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0, priority: UILayoutPriority = .required) -> UIView {
        let leading = leadingAnchor.constraint(equalTo: anchor, constant: constant)
        leading.priority = priority
        leading.isActive = true
        return self
    }
    
    @discardableResult
    public func leadingToGreather(_ anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0) -> UIView {
        leadingAnchor.constraint(greaterThanOrEqualTo: anchor, constant: constant).isActive = true
        return self
    }
    
    @discardableResult
    public func leadingToLess(_ anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0) -> UIView {
        leadingAnchor.constraint(lessThanOrEqualTo: anchor, constant: constant).isActive = true
        return self
    }
    
    @discardableResult
    public func trailingTo(_ anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0, priority: UILayoutPriority = .required) -> UIView {
        let trailing = trailingAnchor.constraint(equalTo: anchor, constant: -constant)
        trailing.priority = priority
        trailing.isActive = true
        return self
    }
    
    @discardableResult
    public func trailingToGreather(_ anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0) -> UIView {
        trailingAnchor.constraint(greaterThanOrEqualTo: anchor, constant: -constant).isActive = true
        return self
    }
    
    @discardableResult
    public func trailingToLess(_ anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0) -> UIView {
        trailingAnchor.constraint(lessThanOrEqualTo: anchor, constant: -constant).isActive = true
        return self
    }
    
    @discardableResult
    public func centerXTo(_ anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0) -> UIView {
        centerXAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        return self
    }
    
    @discardableResult
    public func centerYTo(_ anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0) -> UIView {
        centerYAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        return self
    }
    
    @discardableResult
    public func centerInView(_ viewParent: UIView) -> UIView {
        centerXTo(viewParent.centerXAnchor)
        centerYTo(viewParent.centerYAnchor)
        return self
    }
    
    @discardableResult
    public func width(_ constant: CGFloat) -> UIView {
        widthAnchor.constraint(equalToConstant: constant).isActive = true
        return self
    }
    
    @discardableResult
    public func width(_ anchor: NSLayoutDimension) -> UIView {
        widthAnchor.constraint(equalTo: anchor).isActive = true
        return self
    }
    
    @discardableResult
    public func width(_ constant: CGFloat, priority: UILayoutPriority = .required) -> UIView {
        let width = widthAnchor.constraint(equalToConstant: constant)
        width.priority = priority
        width.isActive = true
        return self
    }
    
    @discardableResult
    public func width(_ anchor: NSLayoutDimension, multiplier: CGFloat = 1.0) -> UIView {
        widthAnchor.constraint(equalTo: anchor, multiplier: multiplier).isActive = true
        return self
    }
    
    @discardableResult
    public func width(_ anchor: NSLayoutDimension, multiplier: CGFloat = 1.0, priority: UILayoutPriority = .required) -> UIView {
        let width = widthAnchor.constraint(equalTo: anchor, multiplier: multiplier)
        width.priority = priority
        width.isActive = true
        return self
    }
    
    @discardableResult
    public func height(_ anchor: NSLayoutDimension) -> UIView {
        heightAnchor.constraint(equalTo: anchor).isActive = true
        return self
    }
    
    @discardableResult
    public func height(_ anchor: NSLayoutDimension, multiplier: CGFloat = 1.0) -> UIView {
        heightAnchor.constraint(equalTo: anchor, multiplier: multiplier).isActive = true
        return self
    }
    
    @discardableResult
    public func height(_ constant: CGFloat, priority: UILayoutPriority = .required) -> UIView {
        let height = heightAnchor.constraint(equalToConstant: constant)
        height.priority = priority
        height.isActive = true
        return self
    }
    
    @discardableResult
    public func height(_ anchor: NSLayoutDimension, multiplier: CGFloat = 1.0, priority: UILayoutPriority = .required) -> UIView {
        let height = heightAnchor.constraint(equalTo: anchor, multiplier: multiplier)
        height.priority = priority
        height.isActive = true
        return self
    }
}
