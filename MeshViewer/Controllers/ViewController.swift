//
//  ViewController.swift
//  MeshViewer
//
//  Created by Li Jie on 30/3/19.
//  Copyright © 2019 Li Jie. All rights reserved.
//

import UIKit
import SceneKit
import SnapKit

class ViewController: UIViewController {

    lazy var scene: SCNScene = {
        let scene = SCNScene()
        
        let floorNode = SCNNode()
        let floor = SCNFloor()
        floorNode.geometry = floor
        floorNode.position = SCNVector3(0, -3, 0)
        let floorPhysicsBody = SCNPhysicsBody(type: SCNPhysicsBodyType.static, shape: SCNPhysicsShape(geometry: floor, options: nil))
        floorNode.physicsBody = floorPhysicsBody
        scene.rootNode.addChildNode(floorNode)
        
        // Create sources
        let vertexSource = SCNGeometrySource(vertices: threeDModel.vertices)
        let normalSource = SCNGeometrySource(normals: threeDModel.normals)

        // Create element
        let solidElement = SCNGeometryElement(indices: threeDModel.faces, primitiveType: .point)

        // Create geometry
        let geometry = SCNGeometry(sources: [vertexSource, normalSource], elements: [solidElement])

        // Set materials
        let solidMaterial = SCNMaterial()
        solidMaterial.diffuse.contents = UIColor.tc.theme
//        solidMaterial.locksAmbientWithDiffuse = true

        geometry.materials = [solidMaterial]

        let cubeNode = SCNNode(geometry: geometry)
        scene.rootNode.addChildNode(cubeNode)

        // camera
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 2)
        scene.rootNode.addChildNode(cameraNode)
        
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light?.type = .omni
        lightNode.position = SCNVector3Make(0, 3, 3)
        scene.rootNode.addChildNode(lightNode)
        
        return scene
    }()
    
    lazy var threeDView: SCNView = {
        let threeDView = SCNView()
        threeDView.scene = scene
        threeDView.backgroundColor = UIColor.tc.background
        threeDView.allowsCameraControl = true
        threeDView.showsStatistics = true
        return threeDView
    }()
    
    lazy var threeDModel: ThreeDModel = {
        return Utils.parseThreeDModel(fromFile: "bunny")
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.tc.background
        view.addSubview(threeDView)
        
        threeDView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
    }
}

