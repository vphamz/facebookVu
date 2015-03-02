//
//  FeedViewController.swift
//  facebookVu
//
//  Created by Vuhuan Pham on 2/27/15.
//  Copyright (c) 2015 Vuhuan Pham. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController, UIViewControllerTransitioningDelegate,  UIViewControllerAnimatedTransitioning {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var homeFeedImage: UIImageView!
    @IBOutlet weak var wedding1Image: UIImageView!
    @IBOutlet weak var wedding2Image: UIImageView!
    @IBOutlet weak var wedding3Image: UIImageView!
    @IBOutlet weak var wedding4Image: UIImageView!
    @IBOutlet weak var wedding5Image: UIImageView!
    
    var selectedImageView: UIImageView!
    var isPresenting: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        
        scrollView.contentSize = homeFeedImage.frame.size
        wedding1Image.clipsToBounds = true
        wedding2Image.clipsToBounds = true
        wedding3Image.clipsToBounds = true
        wedding4Image.clipsToBounds = true
        wedding5Image.clipsToBounds = true
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func animationControllerForPresentedController(presented: UIViewController!, presentingController presenting: UIViewController!, sourceController source: UIViewController!) -> UIViewControllerAnimatedTransitioning! {
        isPresenting = true
        return self
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController!) -> UIViewControllerAnimatedTransitioning! {
        isPresenting = false
        return self
    }
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        // The value here should be the duration of the animations scheduled in the animationTransition method
        return 0.4
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        var containerView = transitionContext.containerView()
        var toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        var fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        
        
        var movingImageView = UIImageView(image: selectedImageView.image)
        movingImageView.contentMode = selectedImageView.contentMode
        movingImageView.clipsToBounds = selectedImageView.clipsToBounds
        movingImageView.frame = selectedImageView.frame
        movingImageView.frame.origin.x = selectedImageView.frame.origin.x
        movingImageView.frame.origin.y = selectedImageView.frame.origin.y - scrollView.contentOffset.y + 110
        
        
        var window = UIApplication.sharedApplication().keyWindow!
        window.addSubview(movingImageView)
        
        
        
        
        if (isPresenting) {
            containerView.addSubview(toViewController.view)
            toViewController.view.alpha = 0
            var detailViewController = toViewController as PhotoViewController
            
            UIView.animateWithDuration(0.4, animations: { () -> Void in
                toViewController.view.alpha = 1
                
                movingImageView.frame.origin.x = detailViewController.imageView.frame.origin.x
                movingImageView.frame.size.width = detailViewController.imageView.frame.size.width
                movingImageView.frame.size.height = self.selectedImageView.image!.size.height * 320 / self.selectedImageView.image!.size.width
                
                movingImageView.center.y = 568/2

                
                }) { (finished: Bool) -> Void in
                    
                    detailViewController.imageView.hidden = false
                    transitionContext.completeTransition(true)
                    movingImageView.removeFromSuperview()
                    
            }
        } else {
            
            var detailViewController = fromViewController as PhotoViewController
            
            
            movingImageView.frame.size.width = detailViewController.imageView.frame.size.width
            movingImageView.frame.size.height = self.selectedImageView.image!.size.height * 320 / self.selectedImageView.image!.size.width
            movingImageView.center.x = 320/2
            movingImageView.center.y = -detailViewController.scrollView.contentOffset.y + 568/2
            
            println(detailViewController.scrollView.contentOffset.y + 568/2)
            
            detailViewController.imageView.hidden = true
            
            UIView.animateWithDuration(0.4, animations: { () -> Void in
                fromViewController.view.alpha = 0
                
                movingImageView.frame = self.selectedImageView.frame
                movingImageView.center.y = self.selectedImageView.center.y - self.scrollView.contentOffset.y + 110

                
                }) { (finished: Bool) -> Void in
                    transitionContext.completeTransition(true)
                    movingImageView.removeFromSuperview()
                    fromViewController.view.removeFromSuperview()
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        var destinationViewController = segue.destinationViewController as PhotoViewController
        
        destinationViewController.photoImage = self.selectedImageView.image
        
        destinationViewController.modalPresentationStyle = UIModalPresentationStyle.Custom
        destinationViewController.transitioningDelegate = self
        
    }
    
    @IBAction func didPressPhoto(sender: AnyObject) {
        
        var imageView = sender.view as UIImageView
        selectedImageView = imageView
        
        performSegueWithIdentifier("photoSegue", sender: self)
        
    }

}
