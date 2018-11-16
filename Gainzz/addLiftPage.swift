//
//  addLiftPage.swift
//  Gainz
//
//  Created by Wyatt Hurst on 10/16/18.
//  Copyright © 2018 Wyatt Hurst. All rights reserved.
//

import UIKit
import Firebase

let inputContainer: UIView = {
    let view = UIView()
    view.backgroundColor = UIColor.lightGray
    view.layer.cornerRadius = 5
    view.layer.masksToBounds = true
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
}()


var addButton: UIButton = {
    let button = UIButton(type: .system)
    button.backgroundColor = UIColor.green
    button.setTitle("Add Lift", for: .normal)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
}()

let liftTextField: UITextField = {
    let tf = UITextField()
    tf.placeholder = "Lift Name"
    tf.translatesAutoresizingMaskIntoConstraints = false
    tf.layer.borderWidth = 1.0
    tf.layer.borderColor = UIColor.black.cgColor
    return tf
}()

let weightTextField: UITextField = {
    let tf = UITextField()
    tf.placeholder = "Weight used"
    tf.translatesAutoresizingMaskIntoConstraints = false
    tf.layer.borderWidth = 1.0
    tf.layer.borderColor = UIColor.black.cgColor
    return tf
}()

let setTextField: UITextField = {
    let tf = UITextField()
    tf.placeholder = "Number of sets performed"
    tf.translatesAutoresizingMaskIntoConstraints = false
    tf.layer.borderWidth = 1.0
    tf.layer.borderColor = UIColor.black.cgColor
    return tf
}()

let repTextField: UITextField = {
    let tf = UITextField()
    tf.placeholder = "Number of sets performed"
    tf.translatesAutoresizingMaskIntoConstraints = false
    tf.layer.borderWidth = 1.0
    tf.layer.borderColor = UIColor.black.cgColor
    return tf
}()
class addLiftPage: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        navigationItem.title = "Add a lift"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.addSubview(inputContainer)
        view.addSubview(addButton)
        addButton.addTarget(self, action: #selector(addLift), for: .touchUpInside)
        setInputConstraints()
        setButtonConstraints()
        
        
    }
    
    
    @objc func addLift()
    {
        
    }
    func setInputConstraints()
    {
        
        //add x,y, width and height
        
        inputContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputContainer.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        inputContainer.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        inputContainer.heightAnchor.constraint(equalToConstant: 400).isActive = true
        
        inputContainer.addSubview(liftTextField)
        inputContainer.addSubview(weightTextField)
        inputContainer.addSubview(setTextField)
        inputContainer.addSubview(repTextField)
        
        liftTextField.leftAnchor.constraint(equalTo: inputContainer.leftAnchor).isActive = true
        liftTextField.topAnchor.constraint(equalTo: inputContainer.topAnchor).isActive = true
        liftTextField.widthAnchor.constraint(equalTo: inputContainer.widthAnchor).isActive = true
        liftTextField.heightAnchor.constraint(equalTo: inputContainer.heightAnchor, multiplier: 1/4).isActive = true
        liftTextField.backgroundColor = UIColor.white
        
        weightTextField.leftAnchor.constraint(equalTo: liftTextField.leftAnchor).isActive = true
        weightTextField.topAnchor.constraint(equalTo: liftTextField.bottomAnchor).isActive = true
        weightTextField.widthAnchor.constraint(equalTo: inputContainer.widthAnchor).isActive = true
        weightTextField.heightAnchor.constraint(equalTo: inputContainer.heightAnchor, multiplier: 1/4).isActive = true
        weightTextField.backgroundColor = UIColor.white
        
        setTextField.leftAnchor.constraint(equalTo: weightTextField.leftAnchor).isActive = true
        setTextField.topAnchor.constraint(equalTo: weightTextField.bottomAnchor).isActive = true
        setTextField.widthAnchor.constraint(equalTo: inputContainer.widthAnchor).isActive = true
        setTextField.heightAnchor.constraint(equalTo: inputContainer.heightAnchor, multiplier: 1/4).isActive = true
        setTextField.backgroundColor = UIColor.white
        
        repTextField.leftAnchor.constraint(equalTo: setTextField.leftAnchor).isActive = true
        repTextField.topAnchor.constraint(equalTo: setTextField.bottomAnchor).isActive = true
        repTextField.widthAnchor.constraint(equalTo: inputContainer.widthAnchor).isActive = true
        repTextField.heightAnchor.constraint(equalTo: inputContainer.heightAnchor, multiplier: 1/4).isActive = true
        repTextField.backgroundColor = UIColor.white
        
        
        
    }
    
    func setButtonConstraints()
    {
        addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        addButton.topAnchor.constraint(equalTo: inputContainer.bottomAnchor, constant: 12).isActive = true
        addButton.widthAnchor.constraint(equalTo: inputContainer.widthAnchor).isActive = true
        addButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
}