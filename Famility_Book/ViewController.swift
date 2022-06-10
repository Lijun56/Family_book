//
//  ViewController.swift
//  LiveVideo
//
//  Created by Stephen Zhu on 6/9/22.
//
import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARImageTrackingConfiguration()
        
        
        //code to input the pics
            //the trackedImages might be nil, use if
            //the inGroupName should be identified with the resourse group name you named in the assets
            //the bundle.main means the currently view page
        if let trackedImages = ARReferenceImage.referenceImages(inGroupNamed: "NewsPaperImages", bundle: Bundle.main) {
            
            configuration.trackingImages = trackedImages
            
            configuration.maximumNumberOfTrackedImages = 1
            
        }

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    // MARK: - ARSCNViewDelegate
    
    
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        
        let node = SCNNode()
        //check if anchor is the anchor for ARimageAnchor, becaue anchor is everydata type
        //if yes, add 3D content the node
        if let imageAnchor = anchor as? ARImageAnchor {
            //make the video node(make video to be displayed
            let videoNode = SKVideoNode(fileNamed: "harry.mp4")
            
            videoNode.play()
            //the size in pixel of the video
            let videoScene = SKScene(size: CGSize(width: 480, height: 360))
            
            //the position of the video should be displayed in the middle of picture/scene
            videoNode.position = CGPoint(x: videoScene.size.width / 2, y: videoScene.size.height / 2)
            
            videoNode.yScale = -1.0
            
            videoScene.addChild(videoNode)
            
            //create plane and add plane property
            let plane = SCNPlane(width: imageAnchor.referenceImage.physicalSize.width, height: imageAnchor.referenceImage.physicalSize.height)
            
            plane.firstMaterial?.diffuse.contents = videoScene
            
            //create plane node, and turn around, and attached to the node, so that the app is able to detect the plane
            let planeNode = SCNNode(geometry: plane)
            
            planeNode.eulerAngles.x = -.pi / 2
            
            node.addChildNode(planeNode)
            
        }
        
        return node
        
    }
    
    
}
