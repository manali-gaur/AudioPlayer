//
//  ViewController.swift
//  AudioPlayer
//
//  Created by Manali Gaur on 20/03/17.
//  Copyright © 2017 Manali Gaur. All rights reserved.
//

import UIKit

class ViewController: UIViewController{
    
    fileprivate var podCastInfo:[PodCast] = []
    @IBOutlet weak var tblView: UITableView!
    fileprivate var imageData:Data?
    fileprivate var imageStoreInfo = [Int:Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ServerApi.instance.getData(urlString: songUrl){
            (result:Data) in
            
            ParseSerialization.instance.parseItems(data: result){
                (result:[PodCast]) in
                
                DispatchQueue.main.async {
                    
                    self.podCastInfo = result
                    self.tblView.reloadData()
                }
            }
            
        }
        DocumentDirectory.createDirectory()
        let directoryPath = DocumentDirectory.getDirectoryPath()
        print("Path: " + (directoryPath as String))
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController:UITableViewDataSource,UITableViewDelegate{
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView,numberOfRowsInSection section: Int) -> Int {
        return self.podCastInfo.count // your number of cell here
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell") as! PodCastTableViewCell
        let podCast = self.podCastInfo[indexPath.row]
        var img = UIImage(named:"")
        
        cell.artistName.text = podCast.description
        cell.trackName.text = podCast.title
        
        if DocumentDirectory.ifFileExist(index: indexPath.row){
            img = DocumentDirectory.getImage(index: indexPath.row)
            cell.iconImage.image = img
        }
        else{
        DispatchQueue.global(qos: .background).async {
            
            let url = URL(string: podCast.imgUrl!)
            self.imageData = try? Data(contentsOf: url!)
            self.imageStoreInfo[indexPath.row] = self.imageData
            img =  UIImage(data: self.imageData!)!
            DocumentDirectory.saveImageDocumentDirectory(image: img!, index: indexPath.row)
            DispatchQueue.main.async {
            cell.iconImage.image = img
            }
        }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // cell selected code here
    }
    
    
    
}

