//
//  ParseSerialization.swift
//  AudioPlayer
//
//  Created by Manali Gaur on 20/03/17.
//  Copyright © 2017 Manali Gaur. All rights reserved.
//

import UIKit

class ParseSerialization {
    
    static let instance = ParseSerialization()
    
    func parseItems(data: Data,completion: @escaping (_ result: [PodCast]) -> Void){
        
            do{
                var PodcastData = [PodCast]()
                if let jsonArray = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)  as? [String:Any]{
                    
                   
                    let jsonArray = jsonArray["results"] as? [[String:Any]]
                    for jsonObj in jsonArray!{
                        
                        //let item = PodCast()
                        let podCast = PodCast()
                        podCast.title = jsonObj["artistName"] as? String
                        podCast.description = jsonObj["trackName"] as? String
                        podCast.imgUrl = jsonObj["artworkUrl100"] as? String
                        podCast.podCastUrl = jsonObj["previewUrl"] as? String
                        
                        PodcastData.append(podCast)
                    }
                }
                
                completion(PodcastData)
                
            }
            catch{
                
            }
    }
}
