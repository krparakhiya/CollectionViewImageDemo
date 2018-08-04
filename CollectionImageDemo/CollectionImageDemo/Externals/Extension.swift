//
//  Extension.swift
//  CollectionImageDemo
//
//  Created by Kirtan on 04/08/18.
//  Copyright © 2018 Kirtan. All rights reserved.
//

import UIKit

extension UIView{
    
    /// When positive, the background of the layer will be drawn with rounded corners. Also effects the mask generated by the `masksToBounds' property. Defaults to zero. Animatable.
    @IBInspectable var cornerRadius: Double {
        get {
            return Double(self.layer.cornerRadius)
        }
        set {
            self.layer.cornerRadius = CGFloat(newValue)
        }
    }
    @IBInspectable var borderWidth: Double {
        get {
            return Double(self.layer.borderWidth)
        }
        set {
            self.layer.borderWidth = CGFloat(newValue)
        }
    }
    
    /// The color of the layer's border. Defaults to opaque black. Colors created from tiled patterns are supported. Animatable.
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: self.layer.borderColor ?? UIColor.clear.cgColor)
        }
        set {
            self.layer.borderColor = newValue?.cgColor
        }
    }
}

extension String{
    func heightForView(_ font : UIFont, width:CGFloat, numberOfLines: Int = 0) -> CGFloat{
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = numberOfLines
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = self
        
        label.sizeToFit()
        return label.frame.height
    }
    
    //Date
    func date(string from : String, to : String) -> String{
        let dateFormatter = DateFormatter()
        let tempLocale = dateFormatter.locale // save locale temporarily
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = from
        let date = dateFormatter.date(from: self)!
        dateFormatter.dateFormat = to
        dateFormatter.locale = tempLocale // reset the locale
        return dateFormatter.string(from: date)
    }
}
