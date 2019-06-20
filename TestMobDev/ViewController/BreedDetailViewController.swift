//
//  BreedDetailViewController.swift
//  TestMobDev
//
//  Created by Rodrigo Astorga on 6/19/19.
//  Copyright © 2019 rastorga. All rights reserved.
//

import UIKit

class BreedDetailViewController: UIViewController {

    private var breedName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let breedName = breedName else { fatalError("Please pass in a valid Breed name") }
        self.title = breedName
        fetchImages(breedName: breedName)
    }
}

//MARK: - Api Call
extension BreedDetailViewController {
    fileprivate func fetchImages(breedName: String){
        
    }
}

//MARK: - Helper
extension BreedDetailViewController {
    static func instantiate(breedName: String) -> BreedDetailViewController {
        guard let vc = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "BreedDetailViewController") as? BreedDetailViewController else { fatalError("Unexpectedly failed getting BreedDetailViewController from Storyboard") }
        
        vc.breedName = breedName
        
        return vc
    }
}
