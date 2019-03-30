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

    var scene = SCNScene()
    
    lazy var threeDView: SCNView = {
        let threeDView = SCNView()
        threeDView.scene = scene
        threeDView.backgroundColor = UIColor.tc.background
        threeDView.allowsCameraControl = true
        
        // camera
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3Make(0, 12, 50)
        cameraNode.rotation = SCNVector4Make(1, 0, 0, -sin(12/50.0))
        scene.rootNode.addChildNode(cameraNode)
        return threeDView
    }()
    
    lazy var threeDModel: ThreeDModel = {
        return Utils.parseThreeDModel(fromFile: "gargoyle")
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.tc.background
        view.addSubview(threeDView)
        setupConstraints()
        
        loadCube()
    }
    
    func setupConstraints() {
        threeDView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
    }

    func loadCube() -> Void {

//        let vertexSource = SCNGeometrySource(vertices: threeDModel.vertices)
//        let normalSource = SCNGeometrySource(normals: threeDModel.normals)

        let vertexSource = SCNGeometrySource(vertices:cubeVertices())
        let normalSource = SCNGeometrySource(normals:cubeNormals())
        let uvSource = SCNGeometrySource(textureCoordinates:cubeUVs())
        
        //创建三角形和线段的element
        //可直接创建Element
        let solidElement = SCNGeometryElement(indices: cubeSolidIndices(), primitiveType: .triangles)
        
        //创建几何体
        let geometry = SCNGeometry(sources: [vertexSource, normalSource, uvSource], elements: [solidElement])
        
        //设置材质,面/线
        let solidMaterial = SCNMaterial()
        solidMaterial.diffuse.contents = UIColor(red: 4/255.0, green: 120.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        solidMaterial.locksAmbientWithDiffuse = true
        
        geometry.materials = [solidMaterial]
        
        
        let cubeNode = SCNNode(geometry: geometry)
        scene.rootNode.addChildNode(cubeNode)
    }

    func cubeVertices() -> [SCNVector3] {
        //cube立方体
        let cubeSide : Float = 15.0;
        let halfSide = cubeSide/2.0;
        
        let vertices:[SCNVector3] = [
            SCNVector3Make(-halfSide, -halfSide,  halfSide),
            SCNVector3Make( halfSide, -halfSide,  halfSide),
            SCNVector3Make(-halfSide, -halfSide, -halfSide),
            SCNVector3Make( halfSide, -halfSide, -halfSide),
            SCNVector3Make(-halfSide,  halfSide,  halfSide),
            SCNVector3Make( halfSide,  halfSide,  halfSide),
            SCNVector3Make(-halfSide,  halfSide, -halfSide),
            SCNVector3Make( halfSide,  halfSide, -halfSide),
            
            // 重复
            SCNVector3Make(-halfSide, -halfSide,  halfSide),
            SCNVector3Make( halfSide, -halfSide,  halfSide),
            SCNVector3Make(-halfSide, -halfSide, -halfSide),
            SCNVector3Make( halfSide, -halfSide, -halfSide),
            SCNVector3Make(-halfSide,  halfSide,  halfSide),
            SCNVector3Make( halfSide,  halfSide,  halfSide),
            SCNVector3Make(-halfSide,  halfSide, -halfSide),
            SCNVector3Make( halfSide,  halfSide, -halfSide),
            
            // 重复
            SCNVector3Make(-halfSide, -halfSide,  halfSide),
            SCNVector3Make( halfSide, -halfSide,  halfSide),
            SCNVector3Make(-halfSide, -halfSide, -halfSide),
            SCNVector3Make( halfSide, -halfSide, -halfSide),
            SCNVector3Make(-halfSide,  halfSide,  halfSide),
            SCNVector3Make( halfSide,  halfSide,  halfSide),
            SCNVector3Make(-halfSide,  halfSide, -halfSide),
            SCNVector3Make( halfSide,  halfSide, -halfSide)
        ]
        
        return vertices
    }
    func cubeNormals() -> [SCNVector3] {
        //法线
        let normals:[SCNVector3] = [
            // up and down
            SCNVector3Make( 0, -1, 0),
            SCNVector3Make( 0, -1, 0),
            SCNVector3Make( 0, -1, 0),
            SCNVector3Make( 0, -1, 0),
            
            SCNVector3Make( 0, 1, 0),
            SCNVector3Make( 0, 1, 0),
            SCNVector3Make( 0, 1, 0),
            SCNVector3Make( 0, 1, 0),
            
            // back and front
            SCNVector3Make( 0, 0,  1),
            SCNVector3Make( 0, 0,  1),
            SCNVector3Make( 0, 0, -1),
            SCNVector3Make( 0, 0, -1),
            
            SCNVector3Make( 0, 0, 1),
            SCNVector3Make( 0, 0, 1),
            SCNVector3Make( 0, 0, -1),
            SCNVector3Make( 0, 0, -1),
            
            // left and right
            SCNVector3Make(-1, 0, 0),
            SCNVector3Make( 1, 0, 0),
            SCNVector3Make(-1, 0, 0),
            SCNVector3Make( 1, 0, 0),
            
            SCNVector3Make(-1, 0, 0),
            SCNVector3Make( 1, 0, 0),
            SCNVector3Make(-1, 0, 0),
            SCNVector3Make( 1, 0, 0),
        ]
        return normals
    }
    
    func cubeUVs() -> [CGPoint] {
        //UVs
        let UVs:[CGPoint] = [
            
            CGPoint(x:0, y:0), // bottom
            CGPoint(x:1, y:0), // bottom
            CGPoint(x:0, y:1), // bottom
            CGPoint(x:1, y:1), // bottom
            
            CGPoint(x:0, y:1), // top
            CGPoint(x:1, y:1), // top
            CGPoint(x:0, y:0), // top
            CGPoint(x:1, y:0), // top
            
            CGPoint(x:0, y:1), // front
            CGPoint(x:1, y:1), // front
            CGPoint(x:1, y:1), // back
            CGPoint(x:0, y:1), // back
            
            CGPoint(x:0, y:0), // front
            CGPoint(x:1, y:0), // front
            CGPoint(x:1, y:0), // back
            CGPoint(x:0, y:0), // back
            
            CGPoint(x:1, y:1), // left
            CGPoint(x:0, y:1), // right
            CGPoint(x:0, y:1), // left
            CGPoint(x:1, y:1), // right
            
            CGPoint(x:1, y:0), // left
            CGPoint(x:0, y:0), // right
            CGPoint(x:0, y:0), // left
            CGPoint(x:1, y:0), // right
        ]
        return UVs
    }
    //返回值为[UInt8],Int型范围过大会出错
    func cubeSolidIndices() -> [UInt8] {
        //六个面索引,共12个三角形的索引
        let solidIndices:[UInt8] = [
            // bottom
            0, 2, 1,
            1, 2, 3,
            // back
            10, 14, 11,  // 2, 6, 3,   + 8
            11, 14, 15,  // 3, 6, 7,   + 8
            // left
            16, 20, 18,  // 0, 4, 2,   + 16
            18, 20, 22,  // 2, 4, 6,   + 16
            // right
            17, 19, 21,  // 1, 3, 5,   + 16
            19, 23, 21,  // 3, 7, 5,   + 16
            // front
            8,  9, 12,  // 0, 1, 4,   + 8
            9, 13, 12,  // 1, 5, 4,   + 8
            // top
            4, 5, 6,
            5, 7, 6
        ]
        return solidIndices
    }
    
    func cubeLineIndices() -> [UInt8] {
        //12条棱+6个面分割线,共18条线的索引
        let lineIndices:[UInt8] = [
            // bottom
            0, 1,
            0, 2,
            1, 3,
            2, 3,
            // top
            4, 5,
            4, 6,
            5, 7,
            6, 7,
            // sides
            0, 4,
            1, 5,
            2, 6,
            3, 7,
            // diagonals
            0, 5,
            1, 7,
            2, 4,
            3, 6,
            1, 2,
            4, 7
        ]
        return lineIndices
    }
}

