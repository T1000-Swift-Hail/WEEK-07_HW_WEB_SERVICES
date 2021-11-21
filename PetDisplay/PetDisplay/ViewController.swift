//
//  ViewController.swift
//  PetDisplay
//
//  Created by Majed Alshammari on 13/04/1443 AH.
//

import UIKit



class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
   
  
    let url = "https://dog.ceo/api/breeds/image/random"
    
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    
    
    
    
    @IBAction func showPet(_ sender: UIButton) {
        imageRequest()
        
    }

    
    func imageRequest() {
    
        URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: {data , response, error in
            
            guard let data = data, error == nil else {
                print("Error occurred")
                return
            }

            if let response = response as? HTTPURLResponse {
                print("Response HTTP Status code: \(response.statusCode)")
            }
            
            
            
            do {
                let getImage: Image = try JSONDecoder().decode(Image.self, from: data)
                print(getImage)
                self.fetchDataImage(pet: getImage)
            }
            catch {
                print("failed to convert \(error.localizedDescription)")
            }
                
            })
                .resume()
            

        }
    
    
    func fetchDataImage(pet: Image) {
        guard let imageUrl = URL(string: pet.message) else {
            print("Wrong image url")
            return
        }
        

        do {
            let petLocal = try Data(contentsOf: imageUrl)
              DispatchQueue.main.async {
                let petImage = UIImage(data: petLocal)
                self.imageView.image = petImage
            }
        } catch {
                print(error)
        }
            
            
            
    }
        
        
        
    }
          

       
    
    

    



    


