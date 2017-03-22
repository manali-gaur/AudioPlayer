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
    var indexValueToPass: Int!
    
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
        cell.tag = indexPath.row
        cell.podCast = podCast
        return cell
    }
       
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "yourSegueIdentifer") {
            
            let navController = segue.destination as! UINavigationController
            let detailController = navController.topViewController as! MusicViewController
            
            detailController.passedValue = tblView.indexPathForSelectedRow?.row
            detailController.podCastInfo = podCastInfo
        }
    }
    
}





