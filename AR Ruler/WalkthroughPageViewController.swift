//
//  WalkthroughPageViewController.swift
//  AR Ruler
//
//  Created by Spoke on 2018/1/23.
//  Copyright © 2018年 Spoke. All rights reserved.
//

import UIKit

class WalkthroughPageViewController: UIPageViewController, UIPageViewControllerDataSource {
    
    var pageHeadings = ["Step 1", "Step 2"]
    var pageImages = ["AR-Ruler-1", "AR-Ruler-2"]
    var pageContent = ["Turn your phone into landscape, and wait for the yellow detection dot to appear on the screenit.", "Touch the screen to specify the start and end positions"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        
        if let startingViewController = contentViewController(at: 0){
            
            setViewControllers([startingViewController], direction: .forward, animated: true, completion: nil)
            
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: - pageViewController Before and After
    /*******************************************************/
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        var index = (viewController as! WalkthroughControllerViewController).index
        index -= 1
        
        return contentViewController(at: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        var index = (viewController as! WalkthroughControllerViewController).index
        index += 1
        
        return contentViewController(at: index)
    }
    
    
    //MARK: - ContentViewController Methods
    /*******************************************************/
    
    func contentViewController(at index:Int) -> WalkthroughControllerViewController? {
        
        if index < 0 || index >= pageHeadings.count {
            return nil
        }
        
        if let pageContentViewController = storyboard?.instantiateViewController(withIdentifier: "WalkthroughControllerViewController") as? WalkthroughControllerViewController {
            
                pageContentViewController.imageFile = pageImages[index]
                pageContentViewController.heading = pageHeadings[index]
                pageContentViewController.content = pageContent[index]
                pageContentViewController.index = index
            
            return pageContentViewController
        }
        return nil
    }
    
    func forward(index: Int) {
        if let nextViewController = contentViewController(at: index + 1) {
            setViewControllers([nextViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    
    
    //MARK: - Add PageController
    /*******************************************************/
    
//    func presentationCount(for pageViewController: UIPageViewController) -> Int {
//        
//        return pageHeadings.count
//    }
//
//    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
//
//        if let pageContentViewController = storyboard?.instantiateViewController(withIdentifier: "WalkthroughControllerViewController") as? WalkthroughControllerViewController {
//
//            return pageContentViewController.index
//        }
//
//        return 0
//
//    }
}
