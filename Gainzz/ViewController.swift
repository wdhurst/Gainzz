//
//  ViewController.swift
//  Gainzz
//
//  Created by Wyatt Hurst on 10/15/18.
//  Copyright © 2018 Wyatt Hurst. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UITableViewController {
    
    let cellId = "cell"
    var LiftNames:[String] = []
    
    @objc func addLift()
    {
        let add = addLiftPage()
        self.navigationController?.pushViewController(add, animated: true)
        
    }
    @objc func logoutUser()
    {
        do{
            try Auth.auth().signOut()
        } catch let logoutError {
            print(logoutError)
        }
        let logout = LoginPage()
        present(logout, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if Auth.auth().currentUser?.uid == nil
        {
            perform(#selector(logoutUser), with: nil, afterDelay: 0)
        }
        navigationItem.title = "Workout Tracker"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addLift))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutUser))
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return LiftNames.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        let lift = LiftNames[indexPath.row]
        cell.textLabel?.text = lift
        return cell
        
    }
    
    
}

