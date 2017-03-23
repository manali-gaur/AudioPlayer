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
        musicArtistName.textAlignment = NSTextAlignment.center
        musicTrackName.textAlignment = NSTextAlignment.center
        initialize(passedValue: passedValue)
    }
    
    
    @IBAction func playMusic(_ sender: UIButton) {
        if audioPlayer.isPlaying {
            sender.setImage(UIImage(named: "play.png"), for: UIControlState.normal)
            audioPlayer.pause()
        } else {
            sender.setImage(UIImage(named: "pause.png"), for: UIControlState.normal)
            audioPlayer.play()
        }
    }
    
    @IBAction func nextSong(_ sender: Any) {
        if self.passedValue == podCastInfo.count-1{
            self.passedValue = 0
        }else{
            self.passedValue = self.passedValue+1
        }
        initialize(passedValue: self.passedValue)
    }
    
    @IBAction func previousSong(_ sender: Any) {
        if self.passedValue == 0{
            self.passedValue = podCastInfo.count-1
        }else{
            self.passedValue = self.passedValue-1
        }
        initialize(passedValue: self.passedValue)
    }
    
    func getSong(){
        let imgAbsolutePath = (URL(string:(podCastInfo[self.passedValue].podCastUrl)!)?.lastPathComponent)!
        var url: URL!
        var songUrl: URL!
        if DocumentDirectory.ifFileExist(fileName:imgAbsolutePath,item: .MusicPlayer){
            url = URL(fileURLWithPath: DocumentDirectory.getPodCast(fileName: imgAbsolutePath))
            playSong(url: url)
        }else{
            DispatchQueue.global(qos: .background).async {
                songUrl = URL(string: (self.podCastInfo[self.passedValue].podCastUrl)!)!
                self.songData = try? Data(contentsOf: songUrl)
                self.songStoreInfo[self.passedValue] = self.songData
                
                DocumentDirectory.saveInDocumentDirectory(data: self.songData!,fileName:imgAbsolutePath, directoryType: SwitchItems.MusicPlayer)
                DispatchQueue.main.async {
                    url = URL(fileURLWithPath: DocumentDirectory.getPodCast(fileName: imgAbsolutePath))
                    self.playSong(url: url)
                }
            }
        }
    }
    
    func playSong(url:URL){
        do{
            try self.audioPlayer = AVAudioPlayer(contentsOf: url)
            self.audioPlayer.play()
        }catch{}

    }
    
    func initialize(passedValue: Int){
        musicArtistName.text = podCastInfo[passedValue].description!
        musicTrackName.text = podCastInfo[passedValue].title!
        
        if let fileName = podCastInfo[passedValue].imgUrl{
          let urlString = URL(string:(fileName))?.lastPathComponent
          musicImage.image = DocumentDirectory.getImage(fileName:urlString!+String(passedValue)+".jpg")
          getSong()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
