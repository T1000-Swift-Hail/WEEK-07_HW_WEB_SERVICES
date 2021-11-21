//
//  ViewController.swift
//  HW_WEB_SERVICES
//
//  Created by Njoud Alrshidi on 16/04/1443 AH.
//

import UIKit

class ViewController: UIViewController {
    let urlSession : URLSession = URLSession(configuration: .default)

    @IBOutlet weak var petImageView: UIImageView!
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
                let newPet : MyPet = try JSONDecoder().decode(MyPet.self, from: data)
                    print(newPet)
                    self.getPetImageFromWeb(pet: newPet)
                    //self.getPetImageFromWebDownloadTask(pet: newPet)
                } catch {
                    print(error)
                }
            }
            
            
            
        })
        
        
        dataTask.resume()
        
        
    }
    
    
    func getPetImageFromWeb(pet : MyPet) {
        
        guard let imageURL = URL(string: pet.message) else {
            
            print("image url is wrong. Check it out")
            return
        }
        
        
        do {
            let imageData =  try Data(contentsOf: imageURL)
            let petImage = UIImage(data: imageData)
            
            DispatchQueue.main.async {
                self.petImageView.image = petImage
            }
            
            
        } catch {
            print(error)
        }
        
    }
    
    
     

    @IBAction func showRandomPetImage(_ sender: UIButton) {
        
        getPetDataFromWeb()
    }
   
}



