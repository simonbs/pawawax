//
//  Pawaview.swift
//  Pawawaps
//
//  Created by Simon Støvring on 29/01/2016.
//  Copyright © 2016 SimonBS. All rights reserved.
//

import Foundation
import UIKit

class Pawaview: UIView {
    let contentView = UIView()
    private let glowImageView = UIImageView()
    
    init() {
        super.init(frame: CGRectZero)
        glowImageView.image = UIImage(named: "glow")
        glowImageView.layer.zPosition = 1000
        glowImageView.alpha = 0
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.clipsToBounds = true
        
        contentView.addSubview(glowImageView)
        addSubview(contentView)
        
        addConstraint(contentView.leadingAnchor.constraintEqualToAnchor(leadingAnchor))
        addConstraint(contentView.trailingAnchor.constraintEqualToAnchor(trailingAnchor))
        addConstraint(contentView.topAnchor.constraintEqualToAnchor(topAnchor))
        addConstraint(contentView.bottomAnchor.constraintEqualToAnchor(bottomAnchor))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func canBecomeFocused() -> Bool {
        return true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateShadow()
        
        let glowImageLength = max(bounds.width, bounds.height)
        glowImageView.frame = CGRectMake((bounds.width - glowImageLength) / 2, -glowImageLength / 2, glowImageLength, glowImageLength)
    }
    
    override func didUpdateFocusInContext(context: UIFocusUpdateContext, withAnimationCoordinator coordinator: UIFocusAnimationCoordinator) {
        super.didUpdateFocusInContext(context, withAnimationCoordinator: coordinator)

        coordinator.addCoordinatedAnimations({
            self.removeParallax()
            self.glowImageView.hidden = !self.focused
            self.glowImageView.alpha = self.focused ? 0.5 : 0
            
            if self.focused {
                self.transform = CGAffineTransformMakeScale(1.1, 1.1)
                self.addParallax()
            } else {
                self.transform = CGAffineTransformIdentity
            }
            
            self.updateShadow()
        },
        completion: nil)
    }
    
    private func updateShadow() {
        let sizeFactor: CGFloat = focused ? 8 : 12
        layer.shadowColor = UIColor.blackColor().CGColor
        layer.shadowOpacity = focused ? 0.8 : 0.6
        layer.shadowOffset = CGSizeMake(0, bounds.height / sizeFactor)
        layer.shadowRadius = bounds.height / sizeFactor
    }
    
    private func addParallax() {
        glowImageView.currentPawawaxEffect = PawawaxEffect.motionEffectsForParallaxUsingRotation(0.1, translation: bounds.width / 2)

        let filteredSubviews = contentView.subviews.filter({ $0 != glowImageView })
        
        contentView.currentPawawaxEffect = PawawaxEffect.motionEffectsForParallaxUsingRotation(0.1, translation: 20)
        filteredSubviews.enumerate().reverse().forEach { idx, view in
            // Interpolate the translation linearly
            let maxTranslation: CGFloat = 15
            let minTranslation: CGFloat = 5
            let translation = (maxTranslation - minTranslation) / CGFloat(filteredSubviews.count) * CGFloat(idx)
            view.currentPawawaxEffect = PawawaxEffect.motionEffectsForParallaxUsingRotation(0, translation: translation)
            // Interpolate the scale linearly
            let maxScale: CGFloat = 1.15
            let scale: CGFloat = 1 + (maxScale - 1) / CGFloat(filteredSubviews.count) * CGFloat(idx)
            view.transform = CGAffineTransformMakeScale(scale, scale)
        }
    }
    
    private func removeParallax() {
        glowImageView.currentPawawaxEffect = nil
        let allViews = [ contentView ] + contentView.subviews
        allViews.forEach { view in
            view.currentPawawaxEffect = nil
            view.transform = CGAffineTransformIdentity
        }
    }
}

extension UIButton {
    private struct AssociatedKeys {
        static var VerticalPawawaxEnabled = "pawawax_verticalPawawaxEnabled"
        static var HorizontalPawawaxEnabled = "pawawax_horizontalPawawaxEnabled"
        static var VerticalPawawaxEffect = "pawawax_verticalPawawaxEffect"
        static var HorizontalPawawaxEffect = "pawawax_verticalPawawaxEffect"
        static var VerticalPawawaxLimit = "pawawax_verticalPawawaxLimit"
        static var HorizontalPawawaxLimit = "pawawax_verticalPawawaxLimit"
    }
    
    var verticalPawawaxEnabled: Bool {
        get { return objc_getAssociatedObject(self, &AssociatedKeys.VerticalPawawaxEnabled) as? Bool ?? false }
        set { objc_setAssociatedObject(self, &AssociatedKeys.VerticalPawawaxEnabled, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
    
    var horizontalPawawaxEnabled: Bool {
        get { return objc_getAssociatedObject(self, &AssociatedKeys.HorizontalPawawaxEnabled) as? Bool ?? false }
        set { objc_setAssociatedObject(self, &AssociatedKeys.HorizontalPawawaxEnabled, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
    
    var verticalPawawaxLimit: CGFloat {
        get { return objc_getAssociatedObject(self, &AssociatedKeys.VerticalPawawaxLimit) as? CGFloat ?? 20 }
        set { objc_setAssociatedObject(self, &AssociatedKeys.VerticalPawawaxLimit, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
    
    var horizontalPawawaxLimit: CGFloat {
        get { return objc_getAssociatedObject(self, &AssociatedKeys.HorizontalPawawaxLimit) as? CGFloat ?? 20 }
        set { objc_setAssociatedObject(self, &AssociatedKeys.HorizontalPawawaxLimit, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
    
    private var verticalPawawaxEffect: UIMotionEffect? {
        get { return objc_getAssociatedObject(self, &AssociatedKeys.VerticalPawawaxEffect) as? UIMotionEffect }
        set {
            if let oldValue = verticalPawawaxEffect {
                removeMotionEffect(oldValue)
            }
            
            if let newValue = newValue {
                addMotionEffect(newValue)
            }
            
            objc_setAssociatedObject(self, &AssociatedKeys.VerticalPawawaxEffect, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    private var horizontalPawawaxEffect: UIMotionEffect? {
        get { return objc_getAssociatedObject(self, &AssociatedKeys.HorizontalPawawaxEffect) as? UIMotionEffect }
        set {
            if let oldValue = horizontalPawawaxEffect {
                removeMotionEffect(oldValue)
            }
            
            if let newValue = newValue {
                addMotionEffect(newValue)
            }
            
            objc_setAssociatedObject(self, &AssociatedKeys.HorizontalPawawaxEffect, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    override public func didUpdateFocusInContext(context: UIFocusUpdateContext, withAnimationCoordinator coordinator: UIFocusAnimationCoordinator) {
        super.didUpdateFocusInContext(context, withAnimationCoordinator: coordinator)
        
        if verticalPawawaxEnabled && focused {
            verticalPawawaxEffect = PawawaxEffect.translationEffectForAxis(.Y, limit: verticalPawawaxLimit)
        } else {
            verticalPawawaxEffect = nil
        }
        
        if horizontalPawawaxEnabled && focused {
            horizontalPawawaxEffect = PawawaxEffect.translationEffectForAxis(.X, limit: horizontalPawawaxLimit)
        } else {
            horizontalPawawaxEffect = nil
        }
    }
}

private extension UIView {
    private struct AssociatedKeys {
        static var CurrentPawawaxEffect = "pawawax_currentPawawaxEffect"
    }
    
    var currentPawawaxEffect: UIMotionEffectGroup? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.CurrentPawawaxEffect) as? UIMotionEffectGroup
        }
        set {
            if let oldValue = currentPawawaxEffect {
                removeMotionEffect(oldValue)
            }
            
            if let newValue = newValue {
                addMotionEffect(newValue)
            }
            
            objc_setAssociatedObject(self, &AssociatedKeys.CurrentPawawaxEffect, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

private struct PawawaxEffect {
    private static func motionEffectsForParallaxUsingRotation(rotation: CGFloat, translation: CGFloat) -> UIMotionEffectGroup {
        let group = UIMotionEffectGroup()
        group.motionEffects = [
            rotationEffectForAxis(.X, angleMultiplier: rotation),
            translationEffectForAxis(.X, limit: translation),
            rotationEffectForAxis(.Y, angleMultiplier: rotation),
            translationEffectForAxis(.Y, limit: translation)
        ]
        return group
    }
    
    private static func rotationEffectForAxis(axis: Axis, angleMultiplier: CGFloat) -> UIMotionEffect {
        let motionValues = MotionValues(axis: axis)
        let rotationEffect = UIInterpolatingMotionEffect(keyPath: "layer.transform", type: motionValues.type)
        let minTransform = rotationTransformWithAngleMultiplier(angleMultiplier * -motionValues.direction, vector: motionValues.vector)
        let maxTransform = rotationTransformWithAngleMultiplier(angleMultiplier * motionValues.direction, vector: motionValues.vector)
        rotationEffect.minimumRelativeValue = NSValue(CATransform3D: minTransform)
        rotationEffect.maximumRelativeValue = NSValue(CATransform3D: maxTransform)
        return rotationEffect
    }
    
    private static func rotationTransformWithAngleMultiplier(angleMultiplier: CGFloat, vector: Vector3D<CGFloat>) -> CATransform3D {
        var transform = CATransform3DIdentity
        transform.m34 = 1.0 / -1000
        return CATransform3DRotate(transform, CGFloat(M_PI_4) * -angleMultiplier, vector.x, vector.y, vector.z);
    }
    
    private static func translationEffectForAxis(axis: Axis, limit: CGFloat) -> UIMotionEffect {
        let motionValues = MotionValues(axis: axis)
        let translationEffect = UIInterpolatingMotionEffect(keyPath: "center." + motionValues.key, type: motionValues.type)
        translationEffect.minimumRelativeValue = -1 * limit
        translationEffect.maximumRelativeValue = 1 * limit
        return translationEffect
    }
}

private struct MotionValues {
    let type: UIInterpolatingMotionEffectType
    let vector: Vector3D<CGFloat>
    let direction: CGFloat
    let key: String
    
    init(axis: Axis) {
        switch axis {
        case .X:
            type = .TiltAlongHorizontalAxis
            vector = Vector3D(x: 0, y: 1, z: 0)
            direction = 1
            key = "x"
        case .Y:
            type = .TiltAlongVerticalAxis
            vector = Vector3D(x: 1, y: 0, z: 0)
            direction = -1
            key = "y"
        }
    }
}

private enum Axis {
    case X
    case Y
}

private struct Vector3D<T: Strideable> {
    let x, y, z: T
}
