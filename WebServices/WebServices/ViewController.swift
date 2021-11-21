//
//  ViewController.swift
//  WebServices
//
//  Created by Asma on 20/11/2021.
//

import UIKit

class ViewController: UIViewController {
    
    let urlSession: URLSession = URLSession(configuration: .default)
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func randomPetImage(_ sender: UIButton) {
        
        getDataFromWeb()
        
    }
    
    
    func getDataFromWeb() {
        
        guard let apiurl = URL(string: "https://dog.ceo/api/breeds/image/random") else {
            print("URL is out of service")
            return
        }
        let urlRequest = URLRequest(url: apiurl)
        
        let dataTask = urlSession.dataTask(with: urlRequest , completionHandler: { data , response , error in
            if let error = error {
                print(error)
            }
            if let data = data {
                
                do {
                    let newPet : Pet = try JSONDecoder().decode(Pet.self, from: data)
                    print(newPet)
                    self.getImageFromWeb(pet: newPet)
                } catch {
                    print(error)
                }
                
            }
        })
        
        dataTask.resume()
        
    }
    
    
    func getImageFromWeb(pet : Pet) {
        
        guard let imageURL = URL(string: pet.message) else {
            print("image url is wrong. Check it out")
            return
        }
        do {
            let imageData =  try Data(contentsOf: imageURL)
            let imagePet = UIImage(data: imageData)
            
            DispatchQueue.main.async {
                self.imageView.image = imagePet
            }
        } catch {
            print(error)
        }
        
    }
    
    
    
}

