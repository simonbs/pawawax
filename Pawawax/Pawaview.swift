//
//  Pawaview.swift
//  Pawawaps
//
//  Created by Simon Støvring on 29/01/2016.
//  Copyright © 2016 SimonBS. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Pawaview

class Pawaview: UIView {
    let contentView = UIView()
    private let glowImageView = UIImageView()
    
    // Alpha of glow when the view has focus
    private static let GlowAlpha: CGFloat = 0.3
    // Scale applied to the glow. The default length of the glow
    // equals the longest side of the view.
    private static let GlowScale: CGFloat = 1.4
    
    // Scale of the view when focused
    private static let FocusScale: CGFloat = 1.088
    // Rotation of the motion effect applied to the view
    private static let Rotation: CGFloat = 0.05
    // Translation of the motion effect applied to the view
    private static let Translation: CGFloat = 10
    
    // Maximum translation of the motion effect applied to the subviews.
    // The translation is interpolated linearly.
    private static let SubviewsMaxTranslation: CGFloat = 10
    // Minimum translation of the motion effect applied to the subviews.
    // The translation is interpolated linearly.
    private static let SubviewsMinTranslation: CGFloat = 5
    // Maximum scale applied to the subviews.
    // The scale is interpolated linearly.
    private static let SubviewsMaxScale: CGFloat = 1.15
    // Minimum scale applied to the subviews.
    // The scale is interpolated linearly.
    private static let SubviewsMinScale: CGFloat = 1
    
    // Opacity of shadow when not focused
    private static let ShadowAlpha: Float = 0.6
    // Opacity of shadow when focused
    private static let ShadowAlphaFocused: Float = 0.8
    
    // Size factor for the shadow when not focused.
    // This is calculated as the height of the view divided by the factor.
    private static let ShadowFactor: CGFloat = 14
    // Size factor for the shadow when focused.
    // This is calculated as the height of the view divided by the factor.
    private static let ShadowFactorFocused: CGFloat = 10
    
    init() {
        super.init(frame: CGRectZero)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setup() {
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateShadow()
        
        let glowImageLength = max(bounds.width, bounds.height) * Pawaview.GlowScale
        glowImageView.frame = CGRect(
            x: (bounds.width - glowImageLength) / 2,
            y: -glowImageLength / 2,
            width: glowImageLength,
            height: glowImageLength)
    }
    
    override func didUpdateFocusInContext(context: UIFocusUpdateContext, withAnimationCoordinator coordinator: UIFocusAnimationCoordinator) {
        super.didUpdateFocusInContext(context, withAnimationCoordinator: coordinator)
        guard let nextFocusedView = context.nextFocusedView else {
            removeParallax()
            return
        }
        
        let isAncestorFocused = focused || isDescendantOfView(nextFocusedView)
        coordinator.addCoordinatedAnimations({
            self.removeParallax()
            self.glowImageView.hidden = !isAncestorFocused
            self.glowImageView.alpha = isAncestorFocused ? Pawaview.GlowAlpha : 0
            
            if isAncestorFocused {
                self.transform = CGAffineTransformMakeScale(Pawaview.FocusScale, Pawaview.FocusScale)
                self.addParallax()
            } else {
                self.transform = CGAffineTransformIdentity
            }
            
            self.updateShadow()
        },
        completion: nil)
    }
    
    private func updateShadow() {
        let sizeFactor: CGFloat = focused ? Pawaview.ShadowFactorFocused : Pawaview.ShadowFactor
        layer.shadowColor = UIColor.blackColor().CGColor
        layer.shadowOpacity = focused ? Pawaview.ShadowAlphaFocused : Pawaview.ShadowAlpha
        layer.shadowOffset = CGSizeMake(0, bounds.height / sizeFactor)
        layer.shadowRadius = bounds.height / sizeFactor
    }
    
    private func addParallax() {
        glowImageView.currentPawawaxEffect = PawawaxEffect.motionEffectsForParallaxUsingRotation(Pawaview.Rotation, translation: bounds.width / 2)
        let filteredSubviews = contentView.subviews.filter({ $0 != glowImageView })
        contentView.currentPawawaxEffect = PawawaxEffect.motionEffectsForParallaxUsingRotation(Pawaview.Rotation, translation: Pawaview.Translation)
        filteredSubviews.enumerate().reverse().forEach { idx, view in
            // Interpolate the translation linearly
            let translation = (Pawaview.SubviewsMaxTranslation - Pawaview.SubviewsMinTranslation) / CGFloat(filteredSubviews.count) * CGFloat(idx)
            view.currentPawawaxEffect = PawawaxEffect.motionEffectsForParallaxUsingRotation(0, translation: translation)
            // Interpolate the scale linearly
            let scale: CGFloat = Pawaview.SubviewsMinScale + (Pawaview.SubviewsMaxScale - Pawaview.SubviewsMinScale) / CGFloat(filteredSubviews.count) * CGFloat(idx)
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

// MARK: - UIView ancestor swizzling

extension UIView {
    // http://nshipster.com/swift-objc-runtime/
    public override class func initialize() {
        struct Static {
            static var token: dispatch_once_t = 0
        }
        
        // Make sure we aren't dealing with a subclass
        guard self == UIView.self else { return }
        
        dispatch_once(&Static.token) {
            let originalSelector = Selector("didUpdateFocusInContext:withAnimationCoordinator:")
            let swizzledSelector = Selector("pawawax_didUpdateFocusInContext:withAnimationCoordinator:")
            
            let originalMethod = class_getInstanceMethod(self, originalSelector)
            let swizzledMethod = class_getInstanceMethod(self, swizzledSelector)
            
            let didAddMethod = class_addMethod(self, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))
            
            if didAddMethod {
                class_replaceMethod(self, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
            } else {
                method_exchangeImplementations(originalMethod, swizzledMethod)
            }
        }
    }
    
    func pawawax_didUpdateFocusInContext(context: UIFocusUpdateContext, withAnimationCoordinator coordinator: UIFocusAnimationCoordinator) {
        self.pawawax_didUpdateFocusInContext(context, withAnimationCoordinator: coordinator)
        if !isKindOfClass(Pawaview.self) {
            notifyPawaviewsOfFocusChange(self, inContext: context, withAnimationCoordinator: coordinator)
        }
    }
    
    private func notifyPawaviewsOfFocusChange(view: UIView, inContext context: UIFocusUpdateContext, withAnimationCoordinator coordinator: UIFocusAnimationCoordinator) {
        if let meAsAPawaview = view as? Pawaview {
            meAsAPawaview.didUpdateFocusInContext(context, withAnimationCoordinator: coordinator)
        }
        
        view.subviews.forEach {
            notifyPawaviewsOfFocusChange($0, inContext: context, withAnimationCoordinator: coordinator)
        }
    }
}

// MARK: - Button helpers

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

// MARK: - Effect on UIView

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

// MARK: - PawawaxEffect

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
