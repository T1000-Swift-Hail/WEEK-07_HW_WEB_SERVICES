//
//  ViewController.swift
//  PetImage
//
//  Created by mac on 16/04/1443 AH.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var PetImage: UIImageView!
    let urlSession : URLSession = URLSession(configuration: .default)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    func getPetImage() {
        guard let apiURL = URL(string: "https://dog.ceo/api/breeds/image/random")else{
            print("you have a wrong url")
            return
        }
        let urlRequest = URLRequest(url: apiURL)
        
        let datTask = urlSession.dataTask(with:urlRequest , completionHandler:{
            data,response,error in
            
            if let error = error {
                
                print(error)
            }
            
            if let data = data {
                print(String(data:data, encoding:.utf8) ?? "NO data there")
                do {
                    let newPet : Pet = try JSONDecoder().decode(Pet.self, from: data )
                    self.getPetImageFromWebDownloadTask(pet: newPet)
                } catch {
                    print(error)
                    
                }
            }
        })
        datTask.resume()
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
                        self.PetImage.image = petImage
                    }
                    
                    
                } catch {
                    print(error)
                }
            }
            
            
            
        })
        
        
        downloadTask.resume()
        
    }
    
    func getPetDataImageFromWeb(){
        guard let imageURL = URL(string: "https://dog.ceo/api/breeds/image/random")else{
            print("image url is wrong. Check it out")
            return
        }
        do {
            let imagData = try Data(contentsOf: imageURL)
            let petImage = UIImage(data: imagData)
            
            self.PetImage.image = petImage
            
        }catch{
            print(error)
        }
    }
    
    @IBAction func PetDoge(_ sender: Any) {
        
        getPetImage()
    }
    
}
