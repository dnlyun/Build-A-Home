//
//  ViewController.swift
//  ver90.0
//
//  Created by Daniel Yun on 2018-11-03.
//  Copyright © 2018 Daniel Yun. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

var decider : Int = 1;

class ViewController: UIViewController {
    @IBOutlet weak var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scene = SCNScene()
        
        sceneView.scene = scene
        
        // Set the view's delegate
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        // Set the scene to the view
        self.sceneView.autoenablesDefaultLighting = true
        self.sceneView.debugOptions  = [.showConstraints, .showLightExtents, ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
        //shows fps rate
        self.sceneView.showsStatistics = true
        self.sceneView.automaticallyUpdatesLighting = true
    }
    
    func addObject() {
        let model1 = BuildModel()
        model1.loadModel()
        model1.position = SCNVector3(0, 0, 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let configuration = ARWorldTrackingConfiguration()
        sceneView.session.run(configuration)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {return}
        let result = sceneView.hitTest(touch.location(in: sceneView), types: [ARHitTestResult.ResultType.featurePoint])
        guard let hitResult = result.last else {return}
        let hitTransform = SCNMatrix4 (hitResult.worldTransform)
        let hitVector = SCNVector3Make(hitTransform.m41, hitTransform.m42, hitTransform.m43)
        createModel(position: hitVector)
    }
    
    
    func createModel(position : SCNVector3){
        let model1 = BuildModel()
        model1.loadModel()
        model1.position = position
        //model1.eulerAngles = SCNVector3Make(0, 0, 0)
        sceneView.scene.rootNode.addChildNode(model1)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
