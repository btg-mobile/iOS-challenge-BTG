//
//  ZoonTransition.swift
//  MarvelApp
//
//  Created by Lucas Moraes on 30/01/19.
//  Copyright © 2019 LSolutions. All rights reserved.
//

import UIKit

protocol ZoomTransitionDelegate {
    func zoomCharacterImageView(for transition: ZoomTransition) -> UIImageView?
    func zoomForBackgroundView(for transition: ZoomTransition) -> UIView?
}

enum TransitionState {
    case initial
    case final
}

class ZoomTransition: NSObject {
    var duration = 0.5
    var operation: UINavigationController.Operation = UINavigationController.Operation.none
    var zoomScale: CGFloat = 15
    var backgroundScale: CGFloat = 0.7
    
    typealias ZoomingViews = (otherView: UIView, imageView: UIImageView)
    
    func configureView(for state: TransitionState, container: UIView, backgroundViewController: UIViewController, viewsInBackground: ZoomingViews, viewsInForeground: ZoomingViews, snapshotViews: ZoomingViews) {
        switch state {
        case .initial:
            backgroundViewController.view.transform = CGAffineTransform.identity
            backgroundViewController.view.alpha = 1
            snapshotViews.imageView.frame = container.convert(viewsInBackground.imageView.frame, from: viewsInBackground.imageView.superview)
            
        case .final:
            backgroundViewController.view.transform = CGAffineTransform(scaleX: backgroundScale, y: backgroundScale)
            backgroundViewController.view.alpha = 0
            snapshotViews.imageView.frame = container.convert(viewsInForeground.imageView.frame, to: viewsInForeground.imageView.superview)
        }
    }
}

extension ZoomTransition: UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let transiDuration = transitionDuration(using: transitionContext)
        let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
        let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        let container = transitionContext.containerView
        
        var backgroundVC = fromVC
        var foregroundVC = toVC
        
        if operation == .pop {
            backgroundVC = toVC
            foregroundVC = fromVC
        }
        
        let maybeBackgroundImageView = (backgroundVC as? ZoomTransitionDelegate)?.zoomCharacterImageView(for: self)
        let maybeForegroundImageView = (foregroundVC as? ZoomTransitionDelegate)?.zoomCharacterImageView(for: self)
        
        // If ViewController do not conform to ZoomTransitionDelegate protocol
        assert(maybeBackgroundImageView != nil, "Cannot find ImageView in background in ViewController")
        assert(maybeForegroundImageView != nil, "Cannot find ImageView in foreground in ViewController")
        
        let backgroundImageView = maybeBackgroundImageView!
        let foregroundImageView = maybeForegroundImageView!
        
        let imageViewSnapshot = UIImageView(image: backgroundImageView.image)
        imageViewSnapshot.contentMode = UIView.ContentMode.scaleAspectFill
        imageViewSnapshot.layer.masksToBounds = true
        
        backgroundImageView.isHidden = true
        foregroundImageView.isHidden = true
        
        let foregroundViewBackgroundColor = foregroundVC.view.backgroundColor
        foregroundVC.view.backgroundColor = UIColor.clear
        container.backgroundColor = UIColor.white
        
        container.addSubview(backgroundVC.view)
        container.addSubview(foregroundVC.view)
        container.addSubview(imageViewSnapshot)
        
        var preTransitionState = TransitionState.initial
        var postTransitionState = TransitionState.final
        
        if operation == .pop {
            preTransitionState = .final
            postTransitionState = .initial
        }
        
        configureView(for: preTransitionState,
                      container: container,
                      backgroundViewController: backgroundVC,
                      viewsInBackground: (backgroundImageView, backgroundImageView),
                      viewsInForeground: (foregroundImageView, foregroundImageView),
                      snapshotViews: (imageViewSnapshot, imageViewSnapshot))
        
        foregroundVC.view.layoutIfNeeded()
        
        UIView.animate(withDuration: transiDuration, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0, options: [], animations: {
            self.configureView(for: postTransitionState,
                          container: container,
                          backgroundViewController: backgroundVC,
                          viewsInBackground: (backgroundImageView, backgroundImageView),
                          viewsInForeground: (foregroundImageView, foregroundImageView),
                          snapshotViews: (imageViewSnapshot, imageViewSnapshot))
        }) { (finished) in
            backgroundVC.view.transform = CGAffineTransform.identity
            imageViewSnapshot.removeFromSuperview()
            backgroundImageView.isHidden = false
            foregroundImageView.isHidden = false
            foregroundVC.view.backgroundColor = foregroundViewBackgroundColor
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}

extension ZoomTransition: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if fromVC is ZoomTransitionDelegate && toVC is ZoomTransitionDelegate {
            self.operation = operation
            return self
        } else {
            return nil
        }
    }
}
