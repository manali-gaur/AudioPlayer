//
//  DocumentDirectory.swift
//  AudioPlayer
//
//  Created by Manali Gaur on 21/03/17.
//  Copyright © 2017 Manali Gaur. All rights reserved.
//

import UIKit

class DocumentDirectory{
    
   class func createDirectory(){
        let fileManager = FileManager.default
        let paths = getDirectoryPath().appending("customDirectory")  
        if !fileManager.fileExists(atPath: paths){
            try! fileManager.createDirectory(atPath: paths, withIntermediateDirectories: true, attributes: nil)
        }else{
            print("Already dictionary created.")
        }
    }
    
   class func getDirectoryPath() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
   class func saveImageDocumentDirectory(image: UIImage, index: Int){
        let fileManager = FileManager.default
        let imageName = "image"+String(index)+".jpg"
        let path = getDirectoryPath().appending(imageName)
        print(path)
        let imageData = UIImageJPEGRepresentation(image, 0.5)
        fileManager.createFile(atPath: path as String, contents: imageData, attributes: nil)
    }
    
    class func getImage(index: Int) -> UIImage{
        let fileManager = FileManager.default
        let imageName = "image"+String(index)+".jpg"
        var image = UIImage(named: "")
        let imagePath = (DocumentDirectory.getDirectoryPath() as NSString).appendingPathComponent(imageName)
        if fileManager.fileExists(atPath: imagePath){
            image = UIImage(contentsOfFile: imagePath)!
        }else{
            print("No Image")
        }
        return image!
    }
}
