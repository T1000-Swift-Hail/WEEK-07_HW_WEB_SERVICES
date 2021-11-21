//
//  ViewController.swift
//  PetImage
//
//  Created by طلال عبيدالله دعيع القلادي on 21/11/2021.
//

import UIKit

class ViewController: UIViewController {
    
    let urlSession : URLSession = URLSession(configuration: .default)
    @IBOutlet weak var petImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    func getPetDataFromWeb(){
        guard let apiURL = URL(string:"https://dog.ceo/api/breeds/image/random")else {
            print("You have a wrong url")
            return
        }
        let urlRequest = URLRequest(url: apiURL)
        let dataTask = urlSession.dataTask(with: urlRequest, completionHandler: {
            data, response, erorr in
            if let erorr = erorr {
                print(erorr)
            }
            if let data = data {
            
                do {
                    let newPet : Pet = try JSONDecoder().decode(Pet.self, from: data)
                    print(newPet)
                    self.getPetDataFromWebDownloadTask(pet: newPet)
                } catch {
                    print(erorr ?? "")
                }
            }
        })
        dataTask.resume()
    }
    func getImageFromWeb(pet : Pet){
        guard let imageURL = URL(string: pet.message) else {
            print("Image url is wrong")
            return
        }
        do{
            let imageData = try Data(contentsOf: imageURL)
            let petImage = UIImage(data: imageData)
            
            DispatchQueue.main.sync {
                self.petImageView.image = petImage
            }
            
        } catch {
            print(error)
        }
        
    }
    
    func getPetDataFromWebDownloadTask (pet: Pet) {
        
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

    
    @IBAction func showRandomPetImage(_ sender: Any) {
        getPetDataFromWeb()
    }
}

