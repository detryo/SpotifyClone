//
//  ViewController.swift
//  SpotifyClone
//
//  Created by Cristian Sedano Arenas on 17/02/2021.
//

import UIKit

class HomeVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"),
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(didTapsettings))
        
        fetchData()
    }
    
    private func fetchData() {
        
        APICaller.shared.getRecommendedGenres { result in
            
            switch result {
            case .success(let model):
                let genres = model.genres
                var seeds = Set<String>()
                
                while seeds.count < 5 {
                    
                    if let random = genres.randomElement() {
                        seeds.insert(random)
                    }
                }
                
                APICaller.shared.getRecommendations(genres: seeds) { _ in
                    
                    
                }
                
            case .failure(let error): break
            }
        }
    }

    @objc func didTapsettings() {
        
        let profileVC = SettingsVC()
        profileVC.title = "settings"
        profileVC.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(profileVC, animated: true)
    }

}

