//
//  NetworkManager.swift
//  CollectionImageDemo
//
//  Created by Kirtan Parakhiya on 03/08/18.
//  Copyright © 2018 Kirtan. All rights reserved.
//

import UIKit

class NetworkManager: NSObject {
    
    class var shared: NetworkManager {
        struct Static{
            static let instance = NetworkManager()
        }
        return Static.instance
    }
    fileprivate override init(){}
    
    func sendHTTPGetMethod(strUrl: String, completionHandler: @escaping (_ response: [String:Any]?, _ error: Error?) -> ()){
        
        let url : URL = URL.init(string: strUrl)!
        let urlRequest:NSMutableURLRequest = NSMutableURLRequest.init(url: url)
        urlRequest.httpMethod = "GET";
        
        let sharedSession = URLSession.shared
        let dataTask : URLSessionTask = sharedSession.dataTask(with: urlRequest as URLRequest, completionHandler: { (data, response, error) in
            //completion Handler
            
            DispatchQueue.main.async(execute: {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
//                completionClosure(self.verifyResponse(isJSONData: isJSONData, data, response: response, error: error as NSError?))
                
                if(error == nil){
                    let responseInJson : [String:Any];
                    do{
                        //                print(String.init(data: data!, encoding: String.Encoding.utf8)!)
                        responseInJson = try JSONSerialization.jsonObject(with: data!, options:[.mutableContainers, .allowFragments]) as! [String:Any]
                        print(responseInJson.debugDescription)
                        
                        completionHandler(responseInJson, nil)
                        
                    }catch(let e){
                        print(e.localizedDescription)
                        completionHandler(nil, e)
                    }
                }else{
                    print(error.debugDescription)
                    completionHandler(nil, error)
                }
            })
        })
        dataTask.resume()
    }

}
