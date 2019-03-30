//
//  ThreeDModel.swift
//  MeshViewer
//
//  Created by Li Jie on 30/3/19.
//  Copyright © 2019 Li Jie. All rights reserved.
//

import UIKit

struct ThreeDVertexModel {
    let x: Float
    let y: Float
    let z: Float
}

struct ThreeDFaceModel {
    let x: Int
    let y: Int
    let z: Int
}

struct ThreeDModel {
    
    let vertices: Array<ThreeDVertexModel>
    let normals: Array<ThreeDVertexModel>
    let faces: Array<ThreeDFaceModel>
}
