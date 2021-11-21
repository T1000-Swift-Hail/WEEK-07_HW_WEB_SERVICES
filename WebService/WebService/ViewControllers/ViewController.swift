//
//  ViewController.swift
//  WebService
//
//  Created by Dalal AlSaidi on 14/04/1443 AH.
//

import UIKit
import Alamofire


class ViewController: UIViewController {
    
    var mypet : [MyPets] = []
    let urlSession : URLSession = URLSession(configuration: .default)

    @IBOutlet weak var myPetsImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    
    @IBAction func showNew(_ sender: UIButton) {
        
        requestImage()
    }
    
    
    func requestImage() {
                    
            guard let apiURL = URL(string: "https://dog.ceo/api/breeds/image/random") else {
                print("you have a wrong url")
                return
            }
            
            let urlRequest = URLRequest(url: apiURL)
            
            let dataTask = urlSession.dataTask(with: urlRequest, completionHandler: { data, response, error in
                
                if let error = error {
                    print(error)
                }
                
                if let data = data {
                   // print(String(data: data, encoding: .utf8) ?? "No data there")
                    
                    do {
                    let newPet : MyPets = try JSONDecoder().decode(MyPets.self, from: data)
                        print(newPet)
                        self.getPetImageFromWeb(pet: newPet)
                    } catch {
                        print(error)
                    }
                }
                
            })
            
            dataTask.resume()
            
        }
        
        
        func getPetImageFromWeb(pet : MyPets) {
            
            guard let imageURL = URL(string: pet.message) else {
                
                print("image url is wrong. Check it out")
                return
            }
            
            
            do {
                let imageData =  try Data(contentsOf: imageURL)
                let petImage = UIImage(data: imageData)
                
                DispatchQueue.main.async {
                    self.myPetsImage.image = petImage
                }
                
                
            } catch {
                print(error)
            }
            
        }
        
    
}



