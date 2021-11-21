//
//  ViewController.swift
//  HW_WEB_SERVICES
//
//  Created by Munira abdullah on 16/04/1443 AH.
//

import UIKit

class ViewController: UIViewController {
    
    let urlSession : URLSession = URLSession(configuration: .default)
    
    @IBOutlet weak var PetImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    func getPetDataFormWeb() {
     

        guard let apiURL = URL(string: "https://dog.ceo/api/breeds/image/random") else {
            print("you have a wrong url")
            return

    }
        
        let urlRequest = URLRequest(url: apiURL)
        
        let dataTask = urlSession.dataTask(with: urlRequest, completionHandler: { data, response,error in
            
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
             
                print("image url is wrong")
                return
                
            }
            
            do {
                let imageData = try Data(contentsOf: imageURL)
                let petImage = UIImage(data: imageData)
                        
                DispatchQueue.main.async {
                    self.PetImageView.image = petImage
                       
                        }
                        
                    } catch {
                        print(error)
                    }
                  
                }
    
    func getPetImageFromWebDownloadTask (pet : Pet) {
        
        guard let imageURL = URL(string: pet.message) else {
            return
        }
        
        let downloadTask = urlSession.downloadTask(with: imageURL, completionHandler: { localURL ,response, error in
           
            
            if let error = error {
                print(error)
            }
            
            if let localURL = localURL {
                do {
                    let imgeDataFromTempFile = try Data(contentsOf: localURL)
                    let petImage = UIImage(data: imgeDataFromTempFile)
                    
                    DispatchQueue.main.async {
                        self.PetImageView.image = petImage
                    }
               
                } catch {
                    print(error)
                }
            }
            
            
        })
        
        downloadTask.resume()
    
    }
        

                               
    @IBAction func showImage(_ sender: Any) {
    
    getPetDataFormWeb()
        
    }
    

}
                           
    
    

