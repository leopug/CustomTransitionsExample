import UIKit

class TransitionDetailsManager: NSObject, UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {
    
    let interactiveTransition = UIPercentDrivenInteractiveTransition()
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        0.5
    }
    
    fileprivate func showAnimation(_ fromViewController: ViewController, _ toViewController: DetailsViewController, _ transitionContext: UIViewControllerContextTransitioning) {
        
        let tempImage = fromViewController.tempImageView
        toViewController.tempImageInitialFrame = tempImage.frame
        toViewController.tempImageView = tempImage
        toViewController.interactiveTransition = interactiveTransition
        toViewController.view.addSubview(tempImage)
                
        toViewController.view.alpha = 0
        
        UIView.animateKeyframes(withDuration: 0.5, delay: 0, options: .calculationModePaced, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.90) {
                UIView.animate(withDuration: 0.90, animations: {
                    tempImage.frame = toViewController.emojiImageViewFinalFrame
                })
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.9, relativeDuration: 0.10) {
                UIView.animate(withDuration: 0.10, animations: {
                    toViewController.view.alpha = 1
                    
                })
            }
        }, completion: { _ in
            transitionContext.completeTransition(true)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1 ) {
                toViewController.detailsImageView.alpha = 1
            }
        })
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        if let toViewController = transitionContext.viewController(forKey: .to) as? DetailsViewController ,
           let fromViewController = transitionContext.viewController(forKey: .from) as? ViewController {
            containerView.addSubview(toViewController.view)
            
            showAnimation(fromViewController, toViewController, transitionContext)
            
        } else if let fromViewController = transitionContext.viewController(forKey: .from) as? DetailsViewController {
            
            containerView.addSubview(fromViewController.view)
            fromViewController.detailsImageView.removeFromSuperview()
            
            UIView.animate(withDuration: 0.5, animations: {
                fromViewController.view.alpha = 0
                fromViewController.tempImageView.frame = fromViewController.tempImageInitialFrame
            }) { _ in
                transitionContext.completeTransition(true)
            }
        }
    }
    
//    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
//        interactiveTransition.completionSpeed = 0.99
//        return interactiveTransition
//    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
}
