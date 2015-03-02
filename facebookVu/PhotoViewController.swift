//
//  PhotoViewController.swift
//  facebookVu
//
//  Created by Vuhuan Pham on 2/27/15.
//  Copyright (c) 2015 Vuhuan Pham. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var blackView: UIImageView!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var photoAction: UIImageView!
    
    var photoImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        imageView.image = photoImage
        imageView.hidden = true
        
        scrollView.contentSize = imageView.frame.size
        scrollView.delegate = self
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    @IBAction func didPressDoneButton(sender: AnyObject) {
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }

    @IBAction func didPanPhotoImage(sender: AnyObject) {
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView!) {
        blackView.alpha = 1 - fabs(scrollView.contentOffset.y/(568/5))
        doneButton.alpha = 1 - fabs(scrollView.contentOffset.y/(568/10))
        photoAction.alpha = 1 - fabs(scrollView.contentOffset.y/(568/10))
        
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView!) {
        
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView!,
        willDecelerate decelerate: Bool) {
           
            if(fabs(scrollView.contentOffset.y/568) > 0.10) {
                dismissViewControllerAnimated(true, completion: nil)
            }
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView!) {
        // This method is called when the scrollview finally stops scrolling.
    }
    
    @IBAction func didPinchPhotoImage(sender: AnyObject) {
        
        
        
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView!) -> UIView! {
        return imageView
    }
    
    
}
