//
//  PodCastTableViewCell.swift
//  AudioPlayer
//
//  Created by Manali Gaur on 20/03/17.
//  Copyright © 2017 Manali Gaur. All rights reserved.
//

import UIKit

class PodCastTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var trackName: UILabel!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var songUrl: UILabel!
    
    fileprivate var imageData:Data?
    fileprivate var imageStoreInfo = [Int:Any]()
    
    var podCast:PodCast?{
        didSet{
            
            self.artistName.text = podCast?.description
            self.trackName.text = podCast?.title
            
            iconImage.layer.shadowColor = UIColor.white.cgColor
            iconImage.layer.shadowOffset = CGSize(width: 2, height: 2)
            iconImage.layer.shadowOpacity = 0.5;
            iconImage.layer.shadowRadius = 7.0;
            
            var img = UIImage(named:"")
            if DocumentDirectory.ifFileExist(fileName:((URL(string:(podCast?.imgUrl)!)?.lastPathComponent)!)+String(self.tag),item:.podCast){
            self.iconImage.image = DocumentDirectory.getImage(fileName:((URL(string:(podCast?.imgUrl)!)?.lastPathComponent)!)+String(self.tag))
            }
            else{
                DispatchQueue.global(qos: .background).async {
                    
                    let url = URL(string: (self.podCast?.imgUrl!)!)
                    self.imageData = try? Data(contentsOf: url!)
                    self.imageStoreInfo[self.tag] = self.imageData
                    img =  UIImage(data: self.imageData!)!
                    DocumentDirectory.saveInDocumentDirectory(data: self.imageData!,fileName: (fileName:((URL(string:(self.podCast?.imgUrl)!)?.lastPathComponent)!)+String(self.tag)+".jpg"), directoryType: SwitchItems.podCast)
                    DispatchQueue.main.async {
                        self.iconImage.image = img
                    }
                }
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
