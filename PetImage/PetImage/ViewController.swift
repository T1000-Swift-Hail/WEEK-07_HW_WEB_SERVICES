//
//  ViewController.swift
//  PetImage
//
//  Created by Anas Hamad on 15/04/1443 AH.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON



class ViewController: UIViewController {
    
    @IBOutlet var showButton: UIButton!
    @IBOutlet var petImage: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func actionButton(_ sender: Any) {
        downloadImages(imageURL: "https://images.dog.ceo//breeds//dhole//n02115913_1233.jpg")
    }
    
    func downloadImages(imageURL: String) {
        AF.request(imageURL, method: .get)
            .validate()
            .responseData(completionHandler: { (responseData) in
                self.petImage.image = UIImage(data: responseData.data!)
            })
    }
    
    
}
