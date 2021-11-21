//
//  ViewController.swift
//  WEBSERVICES H.W
//
//  Created by Seham الشطنان on 16/04/1443 AH.
//

import UIKit

class ViewController: UIViewController {
    
    let urlsSession : URLSession = URLSession(configuration: .default)
    
    
    
    
    @IBOutlet weak var PetImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    func getPetDateFromWeb ()  {
        
        guard let apiURL = URL(string:  "https://dog.ceo/api/breeds/image/random")
                else { print ("you have a wrong url")
            return
            
        }
        
        let urlRequest = URLRequest(url: apiURL)
        let dataTask = urlsSession.dataTask(with: urlRequest, completionHandler: { data,response,error in
    
    
            if let error = error {
            print (error)
        }
                                            if let data = data {
            do {
                let newPet :Pet = try
                JSONDecoder ().decode(Pet.self, from: data)
                print (newPet)
                self.getPetImageFromWebDownloadTask(Pet: newPet)
                
            } catch {
                print (error)
            }
        }
                
                
                
            })
                                            
        dataTask.resume()
      }
       
        func getpetImageFromWeb(pet : Pet) {
                                            
            guard let imageURL = URL(string: pet.message) else {
            print ("image url is wrong")
            return
        }
          
        do {
            let imageData = try Data(contentsOf:imageURL)
            let petImage = UIImage(data:imageData)
           
            DispatchQueue.main.async {
                self.PetImageView.image =
                petImage
            }
            
            
        } catch {
            print (error)
            
        }
            
        }
     
    func getPetImageFromWebDownloadTask (Pet :Pet){
        guard let imageURL = URL (string: Pet.message) else {
                return
            }
                                            
            let downloadTask = urlsSession.downloadTask(with:imageURL, completionHandler: {
                locaIURL , response ,error in
                
                if let error = error {
                    print (error)
                }
                if let locaIURL = locaIURL {
                    do {
                        let imgeDataFromTempFile = try
                        Data(contentsOf: locaIURL)
                        let PetImage = UIImage(data:imgeDataFromTempFile)
                        
                        DispatchQueue.main.async {
                            self.PetImageView.image =
                            PetImage
                        }
                    } catch {
                        print (error)
                        
                }
                }
            })
        
        downloadTask.resume()
    }
                                            
                                            
    @IBAction func ShowRandomPetImage(_ sender: Any) {
    
   
     getPetDateFromWeb()
    }

}
                                           
