//
//  ViewController.swift
//  AR Ruler
//
//  Created by Spoke on 2018/1/21.
//  Copyright © 2018年 Spoke. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {
    
    var sphereNodes = [SCNNode]()
    var textNode = SCNNode()

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if UserDefaults.standard.bool(forKey: "hasViewedWalkthrought") {
            
            return
        }
        
        
        if let pageViewController = storyboard?.instantiateViewController(withIdentifier: "WalkthroughController") as? WalkthroughPageViewController {
            
            present(pageViewController, animated: true, completion: nil)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    
    
    //MARK: - Detected User Touch Method and
    /*******************************************/
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        //If add thired touch method
        if sphereNodes.count >= 2 {
            for dot in sphereNodes {
                dot.removeFromParentNode()
            }
            sphereNodes = [SCNNode]()
        }
        
        if let touchLocation = touches.first?.location(in: sceneView) {
            
            //converting a point that we touching in 2-D space on the screen into a 3-D coordinate
            let hitTestResult = sceneView.hitTest(touchLocation, types: .featurePoint)
            
            if let hitResult = hitTestResult.first{
                addDot(at: hitResult)
            }
        }
    }
    
    
    
    
    //MARK: - Add the addDot Method
    /*******************************************/
    func addDot(at hitResult : ARHitTestResult) {
        
        let sphere = SCNSphere(radius: 0.005)
        
        let sphereMaterial = SCNMaterial()
        sphereMaterial.diffuse.contents = UIColor.red
        
        sphere.materials = [sphereMaterial]
        
        
        let sphereNode = SCNNode(geometry: sphere)

        sphereNode.position = SCNVector3(hitResult.worldTransform.columns.3.x, hitResult.worldTransform.columns.3.y, hitResult.worldTransform.columns.3.z)
        
        
        sceneView.scene.rootNode.addChildNode(sphereNode)
        
        sphereNodes.append(sphereNode)
        
        
        if sphereNodes.count >= 2 {
            calculate()
        }
        
    }
    
    //MARK: - calculate the distance
    /*******************************************/
    func calculate() {
        let start = sphereNodes[0]
        let end = sphereNodes[1]
        
        print(start.position)
        print(end.position)
        
        
//        distance = √ ((x2-x1)^2 + (y2-y1)^2 + (z2-z1)^2)
        let a = end.position.x - start.position.x
        let b = end.position.y - start.position.y
        let c = end.position.z - start.position.z
        
        let distance = sqrt(pow(a, 2) + pow(b, 2) + pow(c, 2)) * 100
        let shortDistance = String(format: "%0.2f", distance)
        
        updateText(text: "\(shortDistance)", atPosition: end.position)
    }
    
    
    //MARK: - Show the Text in screen and NaviBar
    /*******************************************/
    func updateText(text: String, atPosition position: SCNVector3) {
        
        textNode.removeFromParentNode()
        
        let textGeometry = SCNText(string: text, extrusionDepth: 0.5)
        
        self.navigationItem.title = "\(text) cm"
        
        textGeometry.firstMaterial?.diffuse.contents = UIColor.yellow
        
        textNode = SCNNode(geometry: textGeometry)
        
        textNode.position = SCNVector3(position.x, position.y + 0.01, position.z)
        
        textNode.scale = SCNVector3(0.01, 0.01, 0.01)
        
        sceneView.scene.rootNode.addChildNode(textNode)
        
    }

}
