//
//  DogTableViewController.swift
//  TestMobDev
//
//  Created by Rodrigo Astorga on 6/19/19.
//  Copyright © 2019 rastorga. All rights reserved.
//

import UIKit
import Moya

class BreedTableViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    let provider = MoyaProvider<DogApi>()
    
    
    // MARK: - View State
    private var state: State = .loading {
        didSet {
            switch state {
            case .ready:
                print("ready")
                tableView.reloadData()
                activityIndicator.stopAnimating()
            case .loading:
                print("loading")
                activityIndicator.startAnimating()
            case .error:
                print("error")
                activityIndicator.stopAnimating()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1
        state = .loading
        
        // 2
        provider.request(.dogBreedList) { [weak self] result in
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
    }
}

// MARK: - UITableView Delegate & Data Source
extension BreedTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        guard case .ready(let breeds) = state else { return cell }
        
        cell.textLabel?.text = breeds[indexPath.row]

        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard case .ready(let breeds) = state else { return 0 }
        
        return breeds.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        guard case .ready(let breeds) = state else { return }
        
        let comicVC = BreedDetailViewController.instantiate(breedName: breeds[indexPath.item])
        navigationController?.pushViewController(comicVC, animated: true)
    }
}

extension BreedTableViewController {
    enum State {
        case loading
        case ready([String])
        case error
    }
}
