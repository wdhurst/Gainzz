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
    var LiftNames = [Lift]()
        /*var addButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.green
        button.setTitle("Workout Finished", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isOpaque = true
        return button
    }()*/
    
    @objc func addLift()
    {
        let add = addLiftPage()
        add.LiftNames = LiftNames
        print(LiftNames.count)
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
        //self.LiftNames.removeAll()
        present(logout, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if Auth.auth().currentUser?.uid == nil
        {
            perform(#selector(logoutUser), with: nil, afterDelay: 0)
            return
        }
        navigationItem.title = "Workout Tracker"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addLift))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutUser))
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.allowsSelectionDuringEditing = true
        setButtonConstraints()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        setTableView()
        
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let LIFT = LiftNames[indexPath.row]
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "MM;dd;yyyy"
        let currentDate = format.string(from: date)
        let user = Auth.auth().currentUser?.uid
        let ref = Database.database().reference(fromURL: "https://gainzz-4dcf7.firebaseio.com/")
        let updateRef = ref.child("users").child(user!).child("Workouts").child(currentDate).child(LIFT.ID!)
        updateRef.removeValue()
        setTableView()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return LiftNames.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        let lift = LiftNames[indexPath.row]
        cell.textLabel?.text = lift.Name
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let lift = LiftNames[indexPath.row]
        let position = indexPath.row
        let add = addLiftPage()
        add.position = position
        add.LiftNames = LiftNames
        add.LIFT = lift
        self.navigationController?.pushViewController(add, animated: true)
    }
    
    func setButtonConstraints(){
        view.addSubview(addButton)
        addButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        addButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        addButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -24).isActive = true
        addButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }

    
    @objc func setTableView()
    {
        print("ran")
        let uid = Auth.auth().currentUser?.uid
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "MM;dd;yyyy"
        let currentDate = format.string(from: date)
        self.LiftNames.removeAll()
        if uid != nil{
            Database.database().reference().child("users").child(uid!).child("Workouts").child(currentDate).observe(.childAdded, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String: String] {
                let lift = Lift(Name: dictionary["Name"], Reps: dictionary["Reps"], Sets: dictionary["Sets"], Weight: dictionary["Weight"], ID: dictionary["ID"])
                self.LiftNames.append(lift)
                print(snapshot)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                

            }
    
        }, withCancel: nil)
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
}

