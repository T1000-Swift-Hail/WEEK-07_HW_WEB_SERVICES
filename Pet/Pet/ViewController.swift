//
//  ViewController.swift
//  Pet
//
//  Created by Huda N S on 14/04/1443 AH.
//

import UIKit

class ViewController: UIViewController {
    
    let urlSession : URLSession = URLSession(configuration: .default)
    
    @IBOutlet weak var petImge: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    func getPetDataFromWeb(){
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
                    let newPet : Pets = try JSONDecoder().decode(Pets.self, from: data)
                    print(newPet)
                    self.getPetImageFromWeb(pet: newPet)
                } catch {
                    print(error)
                }
            }
        })
        dataTask.resume()
    }
    
    func getPetImageFromWeb(pet : Pets) {
        guard let imageURL = URL(string: pet.message) else {
            print("image url is wrong")
            return
        }
    
        do {
            let imageData =  try Data(contentsOf: imageURL)
            let petImage = UIImage(data: imageData)
            DispatchQueue.main.async {
                self.petImge.image = petImage
            }
            
        } catch {
            print(error)
        }
    }
    
    @IBAction func showNew(_ sender: Any) {
        getPetDataFromWeb()
    }
}
