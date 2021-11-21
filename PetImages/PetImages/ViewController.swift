//
//  ViewController.swift
//  PetImages
//
//  Created by iAbdullah17 on 16/04/1443 AH.
//

import UIKit

class ViewController: UIViewController {
    
    
    let url = URLSession(configuration: .default)
    
    
    @IBOutlet weak var randomImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func getData(){
        guard let apiURL = URL(string: "https://dog.ceo/api/breeds/image/random")
        else {return}
        
        let urlReq = URLRequest(url: apiURL)
        
        let data = url.dataTask(with: urlReq, completionHandler: { data , response , error in
            if let wrong = error {
                print(wrong)
            }
            if let data = data {
                
            
            do {
            let randomPet : Random = try
            JSONDecoder().decode(Random.self, from: data)
            print(randomPet)
            self.webAprroved(random: randomPet)
            } catch{
                print(error)
            }
        
        
    }
        })
        data.resume()
        
    }
    
    
    func webAprroved(random: Random){
        guard let picURL = URL(string: random.message) else {return}
        
        do {
            let imageData = try Data(contentsOf: picURL)
            let petImage = UIImage(data: imageData)
            
            DispatchQueue.main.async {
                self.randomImage.image = petImage
                
            }
        } catch {
            print(error)
        }
        
        
    }
    
    
    
    

    

    
    @IBAction func newImage(_ sender: Any) {
        getData()
    }
    
}

