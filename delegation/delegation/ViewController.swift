//
//  ViewController.swift
//  delegation
//
//  Created by Fatimah Ayeidh on 09/06/1443 AH.
//

import UIKit


class ViewController: UIViewController, LogoDownloaderDelegate {
    
    var loadingLabel :UILabel = {
        let tex = UILabel()
        tex.textColor = .black
        tex.text = "Loading..."
        tex.textAlignment = .center
        tex.font = .systemFont(ofSize: 24, weight: .bold)
        return tex
    }()
    var loginView = UIView()
    var imageView = UIImageView()
    
    var logoDownloader:LogoDownloader?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(loadingLabel)
        view.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        loadingLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            loadingLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 250),
            loadingLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            loadingLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),
        
            imageView.topAnchor.constraint(equalTo: loadingLabel.bottomAnchor, constant: 80),
            imageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            imageView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -300)
        
        ])
      
        imageView.alpha = 0.0
        loginView.alpha = 0.0
        
        let imageURL: String = "https://cdn.spacetelescope.org/archives/images/publicationjpg/heic1509a.jpg"
        
    
        logoDownloader = LogoDownloader(logoURL: imageURL)
       
        logoDownloader?.delegate = self
       
        logoDownloader?.downloadLogo()
       
        if logoDownloader?.delegate == nil {
            loginView.alpha = 1.0
        }
        
    } // end func viewDidLoad()
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
 
    func didFinishDownloading(_ sender: LogoDownloader) {
        imageView.image = logoDownloader?.image
        
        // Animate the appearance of this ViewController's
        // user interface.
        UIView.animate(withDuration: 2.0, delay: 0.5, options: UIView.AnimationOptions.curveEaseIn, animations:  {
            self.loadingLabel.alpha = 0.0
            self.imageView.alpha = 1.0
        }) { (completed:Bool) in
            if (completed) {
                UIView.animate(withDuration: 2.0) {
                    self.loginView.alpha = 1.0
                }
            }
        }
    } // end func didFinishDownloading
    
} // end class ViewController
