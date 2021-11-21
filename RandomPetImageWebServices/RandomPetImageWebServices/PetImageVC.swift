//
//  ViewController.swift
//  RandomPetImageWebServices
//
//  Created by Monafh on 16/04/1443 AH.
//

import UIKit

class PetImageVC: UIViewController {
    
    
    let urlSession : URLSession = URLSession(configuration: .default)
    
    @IBOutlet weak var petImage: UIImageView!
    
    
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
                    let newPetImage : Pet = try JSONDecoder().decode(Pet.self, from: data)
                    print(newPetImage)
                    
                    self.getPetImageFromWebDownloadTask(pet: newPetImage)
                } catch {
                    print(error)
                }
            }
        })
        
        dataTask.resume()
        
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
                    let petImages = UIImage(data: imageDataFromTempFile)
                    
                    DispatchQueue.main.async {
                        self.petImage.image = petImages
                    }
                } catch {
                    print(error)
                }
            }
        })
        downloadTask.resume()
    }
    
    @IBAction func showRandomPetImage(_ sender: Any) {
        
        getPetDataFromWeb()
    }
}

