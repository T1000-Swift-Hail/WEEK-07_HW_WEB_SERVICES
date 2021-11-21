//
//  ViewController.swift
//  WebServesHW_Week_7
//
//  Created by Ahmed Alenazi on 16/04/1443 AH.
//

import UIKit

class ViewController: UIViewController {
    
    
    let urlSession : URLSession = URLSession(configuration: .default)
    
    @IBOutlet weak var petPhoto: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func getPetPhotoFromWeb (){
        guard  let apiURL = URL(string: "https://dog.ceo/api/breeds/image/random") else {
            print("faild")
            return
        }
        let urlRequest = URLRequest(url:apiURL)
        
        let dataTask = urlSession.dataTask(with: urlRequest, completionHandler: { data,response,error in
            
            if let error = error {
                print(error)
            }
            if let data = data {
                print(String(data:data,encoding: .utf8) ?? "")
                do{
                    let newPet : Pet = try JSONDecoder().decode(Pet.self,from: data)
                    print(newPet)
                    self.getPhotoPet(pet: newPet)
                }
                catch
                {
                    print(error)
                }
            }
        })
        
        dataTask.resume()
    }
    
    func getPhotoPet(pet : Pet){
        guard let PhotoURL = URL(string:pet.message)else{
            
            print("Check it out")
            return
        }
        
        do {
            
            let photoData = try Data(contentsOf: PhotoURL)
            
            let petImege = UIImage(data: photoData)
            
            DispatchQueue.main.async {
                self.petPhoto.image = petImege
            }
            
        }
        catch
        {
            
            print(error)
        }
    }
    
    @IBAction func RandomPetPhoto(_ sender: Any) {
        getPetPhotoFromWeb()
    }
    
}
