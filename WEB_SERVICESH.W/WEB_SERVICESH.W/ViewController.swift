//
//  ViewController.swift
//  WEB_SERVICESH.W
//
//  Created by Hesah Alqhtani on 21/11/2021.
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
            guard let apiURl = URL(string: "https://dog.ceo/api/breeds/image/random")else{
              print("you have a wrong url")
             return
                
            }
        let urlRequest = URLRequest(url:apiURl )
            let dataTask = urlSession.dataTask(with: urlRequest, completionHandler: { data , response , Error in
            
                if let Error = Error {
                    print(Error)
                }
                if let data = data {
                    
                    do {
                        let newPet : Pet = try JSONDecoder() .decode(Pet.self, from: data)
                      print(newPet)
//                        self.getPetDataFromWeb(Pet :newPet) for bring data from web
                        self.getImageFromWebDownloadTask(pet: newPet)
                    }catch{
                        
                   print(error)
                    }
                    
                    
                }
                
            })
            dataTask.resume()
    }

    func getPetImageFromWeb(pet:Pet){
            
            guard let imageURL = URL(string: pet.message) else {
                print("image url is wrong . chick it out")
                return
                
            }
            do {
           let imageData = try Data(contentsOf: imageURL)
          let petImage = UIImage(data: imageData)
          
                DispatchQueue.main.sync {
                    self.petImageView.image = petImage
    }
                } catch {
                 print(error)
                    
                }
            
        }
    func getImageFromWebDownloadTask(pet: Pet){
        guard let imageURL = URL(string: pet.message)else {
           return
        }
        let downloadTask = urlSession.downloadTask(with: imageURL,completionHandler: { localURL , response , error in
            
            if let error = error {
                print(error)
            }
            if let localURL = localURL {
                do {
                    let imageDataFromTemperFile = try Data(contentsOf: localURL)
                    let petImage = UIImage(data: imageDataFromTemperFile)
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
        
        
        
    @IBAction func showRandomImage(_ sender: Any) {
        
        getPetDataFromWeb()
        
    }
    

    
}
