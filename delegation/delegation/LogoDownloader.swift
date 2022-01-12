//
//  Protocols.swift
//  delegation
//
//  Created by Fatimah Ayeidh on 09/06/1443 AH.
//

import Foundation
import UIKit


class LogoDownloader {
    
    var logoURL:String
    var image:UIImage?
    var delegate: LogoDownloaderDelegate?
    
    init(logoURL:String) {
        self.logoURL = logoURL
    }
    
    func downloadLogo() {
        
        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
            
           
            let imageURL = URL(string: self.logoURL)
            let imageData = NSData(contentsOf: imageURL!)
            self.image = UIImage(data: imageData! as Data)
            print("image downloaded")
            
            DispatchQueue.main.async {
                
                self.didDownloadImage()
            }
            
        } // end DispatchQueue.global
    }
    
   
    func didDownloadImage() {
        delegate?.didFinishDownloading(self)
    }
    
} // end class LogoDownloader
