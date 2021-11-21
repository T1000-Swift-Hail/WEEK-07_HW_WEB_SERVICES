//
//  ViewController.swift
//  HWWEBSERVICES
//
//  Created by HIND12 on 16/04/1443 AH.
//

import UIKit

class ViewController: UIViewController {
    let urlSession: URLSession =
    URLSession(configuration: .default)

    @IBOutlet weak var petImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    func getpetDataFormWeb()  {
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
                let newPet : Pet = try JSONDecoder().decode(Pet.self, from: data)
                    print(newPet)
                    //self.getPetImageFromWeb(pet: newPet)
                    self.getPetImageFromWebDownloadTask(pet: newPet)
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
                  let petImage = UIImage(data: imageDataFromTempFile)
                  
                    DispatchQueue.main.async {
                      self.petImageView.image = petImage
                    }
                    
                    
                } catch {
                    print(error)
                }
            }
            
            
            
        })
        
        
        downloadTask.resume()
        
    }
        
    @IBAction func ShowRandomPetImage(_ sender: Any) {
        getpetDataFormWeb()
    }
}
  

