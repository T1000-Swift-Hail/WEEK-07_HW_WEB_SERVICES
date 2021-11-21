//
//  ViewController.swift
//  Animals Pet
//
//  Created by AryafAlaqabali on 16/04/1443 AH.
//

import UIKit

class ViewController: UIViewController {
    let urlSession : URLSession = URLSession(configuration: .default)
    
    @IBOutlet weak var petImag: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func getPetDataFromWeb() {
        
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
                
                
                do {
                    let newPet : Pet = try JSONDecoder().decode(Pet.self, from: data)
                    print(newPet)
                    
                    self.getPetImageFromWebDownloadTask(pet: newPet)
                } catch {
                    print(error)
                }
            }
            
            
            
        })
        
        
        dataTask.resume()
        
        
    }
    
    
    func getPetImageFromWeb(pet : Pet) {
        
        guard let imageURL = URL(string: pet.message) else {
            
            print("image url is wrong. Check it out")
            return
        }
        
        
        do {
            let imageData =  try Data(contentsOf: imageURL)
            let petImage = UIImage(data: imageData)
            
            DispatchQueue.main.async {
                self.petImag.image = petImage
            }
            
            
        } catch {
            print(error)
        }
        
    }
    
    
    func getPetImageFromWebDownloadTask (pet : Pet) {
        
        guard let imageURL = URL(string: pet.message) else {
            return
        }
        
        
        let downloadTask = urlSession.downloadTask(with: imageURL, completionHandler: { localURL , response, error in
            
            if let error = error {
                print(error)
            }
            
            if let localURL = localURL {
                
                do {
                    let imageDataFromTempFile = try Data(contentsOf: localURL)
                    let petImage = UIImage(data: imageDataFromTempFile)
                    
                    DispatchQueue.main.async {
                        self.petImag.image = petImage
                    }
                    
                    
                } catch {
                    print(error)
                }
            }
            
            
            
        })
        
        
        downloadTask.resume()
        
    }
    
    @IBAction func showImagPet(_ sender: Any) {
        getPetDataFromWeb()
        
    }
    
}

