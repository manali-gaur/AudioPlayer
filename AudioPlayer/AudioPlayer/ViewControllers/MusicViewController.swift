//
//  MusicViewController.swift
//  AudioPlayer
//
//  Created by Manali Gaur on 21/03/17.
//  Copyright © 2017 Manali Gaur. All rights reserved.
//

import UIKit
import AVFoundation

class MusicViewController: UIViewController {
    
    var passedValue: Int!
    var podCastInfo:[PodCast] = []
    var podCast:Any!
    
    @IBOutlet weak var musicImage: UIImageView!
    @IBOutlet weak var musicTrackName: UILabel!
    @IBOutlet weak var musicArtistName: UILabel!
    
    fileprivate var songData:Data?
    fileprivate var songStoreInfo = [Int:Any]()
    
    var audioPlayer = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.passedValue != nil {
            musicArtistName.text = podCastInfo[self.passedValue].description!
            musicTrackName.text = podCastInfo[self.passedValue].title!
            //musicImage.image = DocumentDirectory.getImage(fileName:(URL(string:(podCastInfo[self.passedValue].imgUrl)!)?.lastPathComponent)!)
        }
        getSong()
    }
    
    
    @IBAction func playMusic(_ sender: Any) {
        if audioPlayer.isPlaying {
            audioPlayer.pause()
        } else {
            audioPlayer.play()
        }
    }
    
    func getSong(){
        let imgAbsolutePath = (URL(string:(podCastInfo[self.passedValue].podCastUrl)!)?.lastPathComponent)!
        
        if DocumentDirectory.ifFileExist(fileName:imgAbsolutePath+".mp3",item: .MusicPlayer){
            
            let url = URL(fileURLWithPath: DocumentDirectory.getPodCast(fileName: imgAbsolutePath+".mp3"))
            do{
                try audioPlayer = AVAudioPlayer(contentsOf: url)
                audioPlayer.play()
            }
            catch{}
        }else{
            DispatchQueue.global(qos: .background).async {
                let url = URL(string: (self.podCastInfo[self.passedValue].podCastUrl)!)
                
                URLSession.shared.downloadTask(with: url!, completionHandler: { (location, response, error) -> Void in
                    guard let location = location, error == nil else { return }
                    do{
                        let path = DocumentDirectory.createDirectory(directoryType: .MusicPlayer).appendingPathComponent(imgAbsolutePath+".m4a")
                        
                        let url = URL(fileURLWithPath:path)
                        
                        try FileManager().moveItem(at:location, to: url)
                        
                        try self.audioPlayer = AVAudioPlayer(contentsOf: url)
                        
                        self.audioPlayer.play()
                        
                        self.audioPlayer.volume = 1
                      
                    } catch{
                        print("This is an error")
                    }
                }).resume()
            }
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
