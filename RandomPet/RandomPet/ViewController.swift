//
//  ViewController.swift
//  RandomPet
//
//  Created by Mac on 21/11/2021.
//

import UIKit


class ViewController: UIViewController {
    
    @IBOutlet weak var petPhoto: UIImageView!
    let urlSession = URLSession(configuration: .default)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
        func getPhotoDataFromWeb(){
            
            guard let apiURL = URL(string:"https://dog.ceo/api/breeds/image/random") else {
                print("wrong url")
                return
            }
            let urlRequest = URLRequest(url: apiURL)
            let dataTask = urlSession.dataTask(with: urlRequest, completionHandler: { data, response, error in
                
                if let error = error {
                    print(error)
                }
               
                if let data = data {
                    print(String(data: data, encoding: .utf8) ?? "No data there")
                    
                    do {
                        let newPet : Pet = try JSONDecoder().decode(Pet.self, from: data)
                        print("kkkkkk\(newPet)")
                        //self.getPetImageFromWeb(pet: newPet)
                        self.getPetPhotoFromWebDownloadTask(pet: newPet)
                    } catch {
                        
                        print(error)
                        
                    }
                    
                }
                
            })
            
            dataTask.resume()
            
            }
        func getPhtoPetFromWeb() {
            
            guard let imageURL = URL(string: "https://dog.ceo/api/breeds/image/random") else {
                
                print("Photo url is wrong")
                return
            }
            
            do {
                let imageData =  try Data(contentsOf: imageURL)
                let petImage = UIImage(data: imageData)
                
                DispatchQueue.main.async {
                    self.petPhoto.image = petImage
                }
                } catch {
                print(error)
                    
                }
        }
        
        func getPetPhotoFromWebDownloadTask (pet : Pet) {
            
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
                            self.petPhoto.image = petImage
                        }
                        
                        
                    } catch {
                        print(error)
                    }
                }
                
            })
            
            downloadTask.resume()
    }
    
    @IBAction func showImage(_ sender: Any) {
        
        getPhotoDataFromWeb()
    }
    
}
