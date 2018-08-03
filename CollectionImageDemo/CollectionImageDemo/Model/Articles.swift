//
//  Articles.swift
//  CollectionImageDemo
//
//  Created by Kirtan Parakhiya on 03/08/18.
//  Copyright © 2018 Kirtan. All rights reserved.
//

import UIKit

class Articles: NSObject {
    
    internal let kAUTHOR :String = "author"
    internal let kTITLE :String = "title"
    internal let kDESC :String = "description"
    
    internal let kURL :String = "url"
    internal let kURLTOIMAGE :String = "urlToImage"
    internal let kPUBLISHEDAT :String = "publishedAt"
    
    internal let kSOURCE :String = "source"
    
    
    var author : String
    var title : String
    var desc : String
    var url : String
    var urlToImage : String
    var publishedAt : String
    
    
    override init (){
        self.author = ""
        self.title = ""
        self.desc = ""
        self.url = ""
        self.urlToImage = ""
        self.publishedAt = ""
    }
    
    func parseArticales(articaleDetails artical:[String:Any]) -> Articles{
        
        if let au = artical[kAUTHOR] as? String{
            self.author = au
        }
        
        if let ti = artical[kTITLE] as? String{
            self.title = ti
        }
        
        if let de = artical[kDESC] as? String{
            self.desc = de
        }
        
        if let u = artical[kURL] as? String{
            self.url = u
        }
        
        if let utoi = artical[kURLTOIMAGE] as? String{
            self.urlToImage = utoi
        }
        
        if let pu = artical[kPUBLISHEDAT] as? String{
            self.publishedAt = pu
        }
        
        return self
    }
    

}
