//
//  ThreeDModel.swift
//  MeshViewer
//
//  Created by Li Jie on 30/3/19.
//  Copyright © 2019 Li Jie. All rights reserved.
//

import UIKit
import SceneKit

struct ThreeDFaceModel {
    let x: Int
    let y: Int
    let z: Int
}

struct ThreeDModel {
    
    let vertices: Array<SCNVector3>
    let normals: Array<SCNVector3>
    let faces: Array<ThreeDFaceModel>
}
