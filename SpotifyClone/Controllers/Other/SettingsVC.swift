//
//  SettingsVC.swift
//  SpotifyClone
//
//  Created by Cristian Sedano Arenas on 17/02/2021.
//

import UIKit

class SettingsVC: UIViewController {
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    private var sections = [Section]()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Setting"
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        configureModels()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = view.bounds
    }
    
    private func configureModels() {
        
        sections.append(Section(title: "Profile", options: [Option(title: "View Your Profile", handler: { [weak self] in
            
            DispatchQueue.main.async {
                self?.viewProfile()
            }
        })]))
        
        sections.append(Section(title: "Account", options: [Option(title: "Sing Out", handler: { [weak self] in
            
            DispatchQueue.main.async {
                self?.singOutTapped()
            }
        })]))
    }
    
    private func viewProfile() {
        
        let profileVC = ProfileVC()
        profileVC.title = "Profile"
        profileVC.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(profileVC, animated: true)
    }
    
    private func singOutTapped() {
        
        
    }
}

extension SettingsVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return sections[section].options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let model = sections[indexPath.section].options[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = model.title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        // Call handler for cell
        let model = sections[indexPath.section].options[indexPath.row]
        
        model.handler()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        let model = sections[section]
        return model.title
    }
}
