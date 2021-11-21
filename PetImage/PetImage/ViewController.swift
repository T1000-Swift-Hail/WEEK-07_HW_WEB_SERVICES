//
//  ViewController.swift
//  PetImage
//
//  Created by Anas Hamad on 15/04/1443 AH.
//

import UIKit






class ViewController: UIViewController {
    
    @IBOutlet var showButton: UIButton!
    @IBOutlet var petImageView: UIImageView!
    let urlSession : URLSession = URLSession(configuration: .default)
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    @IBAction func gitNewPetImage(_ sender: Any) {
        
        gitJason()
        
    }
    
    
    
    func gitJason(){
        guard let apiUrl = URL(string: "https://dog.ceo/api/breeds/image/random") else {return}
        let urlRequest = URLRequest(url: apiUrl)
        let dataTask = urlSession.dataTask(with: urlRequest) { Data, response, Error in
            
            if let Error = Error {
                print(Error)
            }
            if let Data = Data {
                print(String(data: Data, encoding: .utf8) ?? "")
                
                do {
                    let newPet : PetImage = try JSONDecoder().decode(PetImage.self, from: Data)
                    self.getTheImage(pet: newPet)
                    
                }catch{
                    
                    
                    print(error)
                }
            }
        }
        dataTask.resume()
        
    }
    
    
    func getTheImage(pet : PetImage){
        
        
        guard let imageUrl = URL(string: pet.message)
        else{
            return}
        
        do {
            let imageData = try Data(contentsOf: imageUrl)
            let petImage = UIImage(data: imageData)
            DispatchQueue.main.sync {
                
                self.petImageView.image = petImage
            }
        }catch{
            print(error)
            
            
        }
        
    }
    
}






