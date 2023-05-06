//
//  ImageDetailViewController.swift
//  RecetasApp
//
//  Created by Daniel Duran Schutz on 2/05/23.
//

import Foundation
import UIKit

class ImageDetailViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    var url:String? = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.sd_setImage(with:URL(string: self.url ?? ""))
        imageView.enableZoom()
        
    }
    
    func setImage(imageUrl:String = ""){
        self.url = imageUrl
    }
    
}
