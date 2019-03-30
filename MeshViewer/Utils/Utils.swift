//
//  Utils.swift
//  SwiftTemplate
//
//  Created by Jet Lee on 29/5/18.
//  Copyright © 2018 PUPBOSS. All rights reserved.
//

import UIKit
import SceneKit

class Utils {
    class func parseThreeDModel(fromFile file: String) -> ThreeDModel {
        
        var vertices: Array<SCNVector3> = []
        var normals: Array<SCNVector3> = []
        var faces: Array<UInt16> = []
        
        if let filepath = Bundle.main.path(forResource: file, ofType: "txt") {
            do {
                let contents = try String(contentsOfFile: filepath)
                let lines = contents.split(separator:"\n")
                
                for line in lines {
                    if line.starts(with: "Vertex") {
                        
                        let vertexAndNormal = line.components(separatedBy: "  ")[1]
                        let coordinates = vertexAndNormal.components(separatedBy: " ")
                        vertices.append(SCNVector3Make(Float(coordinates[0])!, Float(coordinates[1])!, Float(coordinates[2])!))
                        
                        let x = coordinates[3].replacingOccurrences(of: "{normal=(", with: "")
                        let z = coordinates[5].replacingOccurrences(of: ")}", with: "")
                        let normal = SCNVector3Make(Float(x)!, Float(coordinates[4])!, Float(z)!)
                        normals.append(normal)
                    } else {
                        let face = line.components(separatedBy: "  ")[1]
                        let faceCoordinates = face.components(separatedBy: " ")
                        faces.append(UInt16(faceCoordinates[0])!)
                        faces.append(UInt16(faceCoordinates[1])!)
                        faces.append(UInt16(faceCoordinates[2])!)
                    }
                }
                return ThreeDModel(vertices: vertices, normals: normals, faces: faces)
            } catch {
                return ThreeDModel(vertices: vertices, normals: normals, faces: faces)
            }
        } else {
            return ThreeDModel(vertices: vertices, normals: normals, faces: faces)
        }
    }
    
    class func appName() -> String {
        return Bundle.main.infoDictionary![kCFBundleNameKey as String] as! String
    }
    
    class func appVersion() -> String {
        return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
    }
    
    class func appBuild() -> String {
        return Bundle.main.infoDictionary![kCFBundleVersionKey as String] as! String
    }
    
    class func deviceModel() -> String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        switch identifier {
        case "AppleTV2,1":                                      return "Apple TV 2G"
        case "AppleTV3,1", "AppleTV3,2":                        return "Apple TV 3G"
        case "AppleTV5,3":                                      return "Apple TV 4G"
        case "AppleTV6,2":                                      return "Apple TV 4K"
        
        case "Watch1,1", "Watch1,2":                            return "Apple Watch 1"
        case "Watch2,3", "Watch2,4":                            return "Apple Watch Series 2"
        case "Watch2,6", "Watch2,7":                            return "Apple Watch Series 1"
        case "Watch3,1", "Watch3,2", "Watch3,3", "Watch3,4":    return "Apple Watch Series 3"
        
        case "iPhone1,1":                                       return "iPhone 2G"
        case "iPhone1,2":                                       return "iPhone 3G"
        case "iPhone2,1":                                       return "iPhone 3GS"
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":             return "iPhone 4"
        case "iPhone4,1":                                       return "iPhone 4S"
        case "iPhone5,1", "iPhone5,2":                          return "iPhone 5"
        case "iPhone5,3", "iPhone5,4":                          return "iPhone 5c"
        case "iPhone6,1", "iPhone6,2":                          return "iPhone 5s"
        case "iPhone7,1":                                       return "iPhone 6 Plus"
        case "iPhone7,2":                                       return "iPhone 6"
        case "iPhone8,1":                                       return "iPhone 6s"
        case "iPhone8,2":                                       return "iPhone 6s Plus"
        case "iPhone8,4":                                       return "iPhone SE"
        case "iPhone9,1", "iPhone9,3":                          return "iPhone 7"
        case "iPhone9,2", "iPhone9,4":                          return "iPhone 7 Plus"
        case "iPhone10,1", "iPhone10,4":                        return "iPhone 8"
        case "iPhone10,2", "iPhone10,5":                        return "iPhone 8 Plus"
        case "iPhone10,3", "iPhone10,6":                        return "iPhone X"
            
        case "iPod1,1":                                         return "iPod Touch 1"
        case "iPod2,1":                                         return "iPod Touch 2"
        case "iPod3,1":                                         return "iPod Touch 3"
        case "iPod4,1":                                         return "iPod Touch 4"
        case "iPod5,1":                                         return "iPod Touch 5"
        case "iPod7,1":                                         return "iPod Touch 6"
            
        case "iPad1,1":                                         return "iPad 1"
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":        return "iPad 2"
        case "iPad2,5", "iPad2,6", "iPad2,7":                   return "iPad Mini 1G"
        case "iPad3,1", "iPad3,2", "iPad3,3":                   return "iPad 3"
        case "iPad3,4", "iPad3,5", "iPad3,6":                   return "iPad 4"
        case "iPad4,1", "iPad4,2", "iPad4,3":                   return "iPad Air"
        case "iPad4,4", "iPad4,5", "iPad4,6":                   return "iPad Mini 2G"
        case "iPad4,7", "iPad4,8", "iPad4,9":                   return "iPad Mini 3"
        case "iPad5,1", "iPad5,2":                              return "iPad mini 4"
        case "iPad5,3", "iPad5,4":                              return "iPad Air 2"
        case "iPad6,3", "iPad6,4":                              return "iPad Pro (9.7 inch)"
        case "iPad6,7", "iPad6,8":                              return "iPad Pro (12.9 inch)"
        case "iPad6,11", "iPad6,12":                            return "iPad 5"
        case "iPad7,1", "iPad7,2":                              return "iPad Pro 2 (12.9 inch)"
        case "iPad7,3", "iPad7,4":                              return "iPad Pro (10.5 inch)"
        case "iPad7,5", "iPad7,6":                              return "iPad 6"
            
        case "i386", "x86_64":                                  return "iPhone Simulator"
        default: return identifier
        }
    }
    
    class func systemVersion() -> String {
        return UIDevice.current.systemVersion
    }
}
