//
//  WalkthroughControllerViewController.swift
//  AR Ruler
//
//  Created by Spoke on 2018/1/23.
//  Copyright © 2018年 Spoke. All rights reserved.
//

import UIKit

class WalkthroughControllerViewController: UIViewController {
    
    
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var contentImageView: UIImageView!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var forwardButton: UIButton!
    
    
    var index = 0
    var heading = ""
    var imageFile = ""
    var content = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headingLabel.text = heading
        contentLabel.text = content
        contentImageView.image = UIImage(named: imageFile)
        
        pageControl.currentPage = index
        
        switch index {
        case 0: forwardButton.setTitle("NEXT", for: .normal)
        case 1: forwardButton.setTitle("DONE", for: .normal)
        default: break
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        
        switch index {
            
        //NEXT
        case 0:
            let pageViewController = parent as! WalkthroughPageViewController
            pageViewController.forward(index: index)
        
        //DONE
        case 1:
            UserDefaults.standard.set(true, forKey: "hasViewedWalkthrought")
            dismiss(animated: true, completion: nil)
        default:
            break
        }
        
    }
    


}
