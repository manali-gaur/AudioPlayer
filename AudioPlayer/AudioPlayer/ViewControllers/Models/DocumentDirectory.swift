//
//  DocumentDirectory.swift
//  AudioPlayer
//
//  Created by Manali Gaur on 21/03/17.
//  Copyright © 2017 Manali Gaur. All rights reserved.
//

import UIKit

enum SwitchItems{
    case podCast,MusicPlayer
}
class DocumentDirectory{
    
    class func createDirectory(directoryType: SwitchItems)->NSString{
        let fileManager = FileManager.default
        var paths: String
        
        switch directoryType{
        case .podCast:
        paths = getDirectoryPath().appendingPathComponent("PodCast")
        case .MusicPlayer:
        paths = getDirectoryPath().appendingPathComponent("MusicPlayer")
        }
        if !fileManager.fileExists(atPath: paths){
            try! fileManager.createDirectory(atPath: paths, withIntermediateDirectories: true, attributes: nil)
        }else{
            print("Already dictionary created.")
        }
        return paths as NSString
    }
    
    class func getDirectoryPath() -> NSString {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0] as NSString
        return documentsDirectory
    }
    
    class func saveInDocumentDirectory(data: Data, fileName: String, directoryType: SwitchItems){
        
            let songName = fileName
            let path = createDirectory(directoryType: directoryType).appendingPathComponent(songName)
            print(path)
            let songData = data
            do{
                try songData.write(to: URL(fileURLWithPath:path))
            }catch{}
    }
    
    class func ifFileExist(fileName: String,item: SwitchItems)->Bool{
        let fileManager = FileManager.default
        let imageName = fileName
        let imagePath = createDirectory(directoryType: item).appendingPathComponent(imageName)
        if fileManager.fileExists(atPath: imagePath){
            return true
        }else{
            return false
        }
    }
    
    class func getPodCast(fileName:String) -> String{
        let imageName = fileName
        let path = createDirectory(directoryType: SwitchItems.MusicPlayer).appendingPathComponent(imageName)
        return path
    }
    
    class func getImage(fileName:String) -> UIImage{
        let imageName = fileName
        var image = UIImage(named: "")
        let imagePath = createDirectory(directoryType: SwitchItems.podCast).appendingPathComponent(imageName)
        image = UIImage(contentsOfFile: imagePath)
        return image!
    }
}
