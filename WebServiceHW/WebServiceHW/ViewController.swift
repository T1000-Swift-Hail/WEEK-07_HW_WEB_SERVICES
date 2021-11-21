//
//  ViewController.swift
//  WebServiceHW
//
//  Created by MACBOOK on 16/04/1443 AH.
//

import UIKit

class ViewController: UIViewController {

    
    let urlSession : URLSession = URLSession(configuration: .default)
    
    @IBOutlet weak var petteImageView: UIImageView!
    
    @IBAction func showRandomPetImage(_ sender: Any) {
        
        getPetDataFromWeb()
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func getPetDataFromWeb() {
        
        guard let apiURL = URL(string: "https://dog.ceo/api/breeds/image/random")
            
        else {
            
            print("u Have a Wrong URL")
            return
        }
        
        let urlRequest = URLRequest(url: apiURL)
        let dataTask = urlSession.dataTask(with: urlRequest, completionHandler:{ data, response, error in
            
            if let error = error {
                print(error)
            }
            
            if let data = data {
                print(String(data: data, encoding: .utf8) ?? "Sorry No data there")
                
                do {
                    
                    let newPet : Pet = try JSONDecoder().decode(Pet.self, from: data)
                    print(newPet)
                    
                    self.getPetImageFromWebDownloadTask(pet: newPet)
//                    let petImage = UIImage(data: imageData)
//                    self.getPetDataFromWeb(pet: newPet)
                    
//                    DispatchQueue.main.async {
//                        self.petteImageView.image = petImage
//                    }
                    
                } catch {
                    
                    print(error)
                }
            }  
        })
        
        dataTask.resume()
    }

    func getPetImageFromWeb(pet:Pet) {
        
        guard let imageURL = URL(string: pet.message) else {
            
            print("image url is wrong please check out ")
            return
        }
        
        do {
            
            let imageData = try Data(contentsOf: imageURL)
            let petImage = UIImage(data: imageData)
            
            DispatchQueue.main.async {
                
                self.petteImageView.image = petImage
            }
        } catch {
            
            print(error)
        }
    }
    
    func getPetImageFromWebDownloadTask(pet:Pet) {
        
        guard let imageURL = URL(string: pet.message) else {
            
            return
        }
        
        let downloadTask = urlSession.downloadTask(with:imageURL,completionHandler:{localURL,response,error in
            
            
            if let error = error {
                
                print(error)
            }
            
            if let localURL = localURL {
                
                do {
                    let imageDataFromTempFile = try Data(contentsOf: localURL)
                    let petImage = UIImage(data: imageDataFromTempFile)
                    
                    DispatchQueue.main.async {
                        self.petteImageView.image = petImage
                    }
                    
                    
                } catch {
                    
                    print(error)
                }
            }
        })
        
        downloadTask.resume()
    }

}

