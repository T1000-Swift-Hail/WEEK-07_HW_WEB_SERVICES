//
//  ViewController.swift
//  WEB_SERVICES HW
//
//  Created by موضي الحربي on 16/04/1443 AH.
//

import UIKit

class ViewController: UIViewController {

    let urlSession : URLSession = URLSession(configuration: .default)
    
    
    @IBOutlet weak var petImage: UIImageView!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
   
    }


    func getPetFromWeb() {
        
        guard let iURL = URL(string: "https://dog.ceo/api/breeds/image/random") else {
            print ("you have a wrong url")
        return
        
        }
        
        let urIRequest = URLRequest(url: iURL)
        
        let dataTask = urlSession.dataTask(with: urIRequest, completionHandler: { data, response , error in
            
            if let error = error {
           print(error)
        }
        
            if let data = data {
               
                do {
                    
                let newPet : Pet = try JSONDecoder().decode(Pet.self, from: data)
                     print(newPet)
                    self.getPetImegeFromWebDownloadTask(pet: newPet)
                
                
                } catch {
                     print(error)
                    
                }
            }
                    
        })
                    
               
                
        dataTask.resume()
    

    }
     
    func getPetImageFromWeb(pet : Pet) {
      
        guard let imageURL = URL(string: pet.message) else {
            
            print("image url is wrong. Check out")
            return
        }
    
        do {
            let imageData = try Data(contentsOf: imageURL)
            let petImage = UIImage(data: imageData)
            
            DispatchQueue.main.async {
                self.petImage.image = petImage
                 
               }
            
            
             }  catch {
                  print(error)
             }
         }
    
    
    func getPetImegeFromWebDownloadTask (pet : Pet) {
        
        guard let imageURL = URL(string: pet.message) else {
            
            return
        }
    
        let download = urlSession.downloadTask(with: imageURL, completionHandler: {localURL , response , error in
            
             
            if let error = error {
                print (error)
            }
        
            if let localURL = localURL {
                
                do {
                    let imageDataFromFile = try Data(contentsOf: localURL)
                    let petImage = UIImage(data: imageDataFromFile)
           
                    DispatchQueue.main.async {
                        self.petImage.image = petImage
                    }
               
                } catch  {
                    print(error)
        
                }
    
            }
            
        })
            
        download.resume()
        
    }
        
    @IBAction func showRandomPetImage(_ sender: Any) {
    
        
    getPetFromWeb()
    }
    
}

