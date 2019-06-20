//
//  BreedDetailViewController.swift
//  TestMobDev
//
//  Created by Rodrigo Astorga on 6/19/19.
//  Copyright © 2019 rastorga. All rights reserved.
//

import UIKit
import Moya
import SDWebImage

class BreedDetailViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var breedName: String?

    let provider = MoyaProvider<DogApi>()
    
    
    // MARK: - View State
    private var state: State = .loading {
        didSet {
            switch state {
            case .ready:
                print("ready")
                collectionView.reloadData()
            case .loading:
                print("loading")
            case .error:
                print("error")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let breedName = breedName else { fatalError("Please pass in a valid Breed name") }
        self.title = breedName
        
        // 1
        state = .loading
        
        // 2
        provider.request(.dogBreedDetail(breedName)) { [weak self] result in
            guard let self = self else { return }
        
            // 3
            switch result {
            case .success(let response):
            do {
            // 4
            self.state = .ready(try response.map(DogApiResponse<String>.self).message)
            } catch {
            self.state = .error
            }
            case .failure:
            // 5
            self.state = .error
            }
        }
        fetchImages(breedName: breedName)
    }
}

//MARK: - Api Call
extension BreedDetailViewController {
    fileprivate func fetchImages(breedName: String){
        
    }
}

//MARK: - CollectionView Data Source & Delegate
extension BreedDetailViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard case .ready(let breedImages) = state else { return 0 }
        
        return breedImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailBreedItem", for: indexPath)
        guard case .ready(let breedImages) = state else { return cell }
        
        guard !breedImages[indexPath.row].isEmpty, let url = URL(string: breedImages[indexPath.row]) else {
            return UICollectionViewCell()
        }
        let imageView = UIImageView(frame: .init(x: 0, y: 0, width: 100, height: 100))
        imageView.contentMode = .scaleAspectFit
        cell.contentView.addSubview(imageView)
        imageView.topAnchor.constraint(equalTo: cell.topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: cell.bottomAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: cell.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: cell.trailingAnchor).isActive = true
        
        imageView.sd_setImage(with: url, placeholderImage: nil)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: self.view.frame.width / 2, height: 100)
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
    
extension BreedDetailViewController {
    enum State {
        case loading
        case ready([String])
        case error
    }
}
