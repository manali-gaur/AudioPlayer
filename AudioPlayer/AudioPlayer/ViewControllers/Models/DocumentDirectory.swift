//
//  DocumentDirectory.swift
//  AudioPlayer
//
//  Created by Manali Gaur on 21/03/17.
//  Copyright © 2017 Manali Gaur. All rights reserved.
//

import UIKit

class DocumentDirectory{
    
   class func createDirectory()->NSString{
        let fileManager = FileManager.default
        let paths = getDirectoryPath().appendingPathComponent("CustomDirectory")

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
    
   class func saveImageDocumentDirectory(image: UIImage, index: Int){
        //let fileManager = FileManager.default
        let imageName = "image"+String(index)+".jpg"
        let path = createDirectory().appendingPathComponent(imageName)
        print(path)
        let imageData = UIImageJPEGRepresentation(image, 0.5)
        do{
        try imageData?.write(to: URL(fileURLWithPath:path))
       }catch{}
    
    }
    
    class func ifFileExist(index: Int)->Bool{
        let fileManager = FileManager.default
        let imageName = "image"+String(index)+".jpg"
        let imagePath = createDirectory().appendingPathComponent(imageName)
        if fileManager.fileExists(atPath: imagePath){
           return true
        }else{
            return false
        }
    }
    class func getImage(index: Int) -> UIImage{
        let imageName = "image"+String(index)+".jpg"
        var image = UIImage(named: "")
        let imagePath = createDirectory().appendingPathComponent(imageName)
        image = UIImage(contentsOfFile: imagePath)
        return image!
    }
}
