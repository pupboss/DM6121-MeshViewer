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
import CoreMotion

class ViewController: UIViewController {
    
    lazy var objectNode: SCNNode = {
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
        
        return SCNNode(geometry: geometry)
    }()

    lazy var scene: SCNScene = {
        let scene = SCNScene()
        
        let floorNode = SCNNode()
        let floor = SCNFloor()
        floorNode.geometry = floor
        floorNode.position = SCNVector3(0, -2, 0)
        let floorPhysicsBody = SCNPhysicsBody(type: SCNPhysicsBodyType.static, shape: SCNPhysicsShape(geometry: floor, options: nil))
        floorNode.physicsBody = floorPhysicsBody
        scene.rootNode.addChildNode(floorNode)
        
        scene.rootNode.addChildNode(objectNode)

        // camera
        let cameraNode = SCNNode()
        let camera = SCNCamera()
        camera.fieldOfView = 15
        cameraNode.camera = camera
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
    
    lazy var switchLabel: UILabel = {
        let switchLabel = UILabel()
        switchLabel.text = "Accelerometer:"
        switchLabel.textColor = UIColor.tc.subBackground
        switchLabel.font = UIFont.systemFont(ofSize: 15)
        return switchLabel
    }()
    
    lazy var switchControl: UISwitch = {
        let switchControl = UISwitch()
        switchControl.isUserInteractionEnabled = true
        return switchControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.tc.background
        view.addSubview(threeDView)
        view.addSubview(switchLabel)
        view.addSubview(switchControl)
        
        threeDView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        switchLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(view).offset(16)
            make.bottom.equalTo(view).offset(-30)
        }
        switchControl.snp.makeConstraints { (make) in
            make.centerY.equalTo(switchLabel)
            make.leading.equalTo(switchLabel.snp.trailing).offset(16)
        }
    }
}

