//
//  ServerAPi.swift
//  AudioPlayer
//
//  Created by Manali Gaur on 20/03/17.
//  Copyright © 2017 Manali Gaur. All rights reserved.
//

import UIKit

class ServerApi: NSObject {
    
    static let instance = ServerApi()

    
    func getData(urlString:String,completion: @escaping (_ result: Data) -> Void) {
        
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        var dataTask: URLSessionDataTask?
        
        if dataTask != nil {
            dataTask?.cancel()
        }
        
        let url = URL(string:urlString)
        
        dataTask = defaultSession.dataTask(with: url!, completionHandler: {
            data, response, error in
            
          
            if let error = error {
                print(error.localizedDescription)
                //Add alert in this particular place
            } else if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    completion(data!)
                }
            }
        })
        dataTask?.resume()
    }
}
