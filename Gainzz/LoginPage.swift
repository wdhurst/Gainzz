//
//  addLiftPage.swift
//  Gainz
//
//  Created by Wyatt Hurst on 10/16/18.
//  Copyright © 2018 Wyatt Hurst. All rights reserved.
//

import UIKit
import Firebase

let loginContainer: UIView = {
    let view = UIView()
    view.backgroundColor = UIColor.lightGray
    view.layer.cornerRadius = 5
    view.layer.masksToBounds = true
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
}()


var loginButton: UIButton = {
    let button = UIButton(type: .system)
    button.backgroundColor = UIColor.cyan
    button.setTitle("Login", for: .normal)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.titleLabel?.textColor = UIColor.white
    return button
}()

let nameTextField: UITextField = {
    let tf = UITextField()
    tf.placeholder = "Name"
    tf.translatesAutoresizingMaskIntoConstraints = false
    tf.layer.borderWidth = 1.0
    tf.layer.borderColor = UIColor.black.cgColor
    return tf
}()

let emailTextField: UITextField = {
    let tf = UITextField()
    tf.placeholder = "E-mail"
    tf.translatesAutoresizingMaskIntoConstraints = false
    tf.layer.borderWidth = 1.0
    tf.layer.borderColor = UIColor.black.cgColor
    return tf
}()

let passwordTextField: UITextField = {
    let tf = UITextField()
    tf.placeholder = "Password"
    tf.translatesAutoresizingMaskIntoConstraints = false
    tf.layer.borderWidth = 1.0
    tf.layer.borderColor = UIColor.black.cgColor
    tf.isSecureTextEntry = true
    tf.textContentType = nil
    return tf
}()

let loginImage: UIImageView = {
    let image = UIImageView()
    image.image = UIImage(named: "images")
    image.translatesAutoresizingMaskIntoConstraints = false
    image.layer.cornerRadius = 5
    image.contentMode = .scaleAspectFill
    return image
}()

let loginRegisterControl: UISegmentedControl = {
    let sc = UISegmentedControl(items: ["Login","Register"])
    sc.translatesAutoresizingMaskIntoConstraints = false
    sc.tintColor = UIColor.gray
    sc.selectedSegmentIndex = 0
    return sc
}()



class LoginPage: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        view.addSubview(loginContainer)
        view.addSubview(loginButton)
        view.addSubview(loginImage)
        view.addSubview(loginRegisterControl)
        loginButton.addTarget(self, action: #selector(regOrLogin), for: .touchUpInside)
        loginRegisterControl.addTarget(self, action: #selector(handleSwitch), for: .allEvents)
        setButtonConstraints()
        setLoginImage()
        setSegmentedControl()
        setInputConstraints()
        handleSwitch()
        
        
    }
    
    @objc func handleSwitch()
    {
        let title = loginRegisterControl.titleForSegment(at: loginRegisterControl.selectedSegmentIndex)
        loginButton.setTitle(title, for: .normal)
        
        /*setting height based on toggle
        setting name size based on toggle*/
        nameFieldHeight.isActive = false
        nameFieldHeight = nameTextField.heightAnchor.constraint(equalTo: loginContainer.heightAnchor, multiplier: loginRegisterControl.selectedSegmentIndex == 1 ? 1/3 : 0)
        nameFieldHeight.isActive = true
        //setting email size based on toggle
        emailFieldHeight.isActive = false
        emailFieldHeight = emailTextField.heightAnchor.constraint(equalTo: loginContainer.heightAnchor, multiplier: loginRegisterControl.selectedSegmentIndex == 1 ? 1/3 : 1/2)
        emailFieldHeight.isActive = true
        //setting password size based on toggle
        passFieldHeight.isActive = false
        passFieldHeight = passwordTextField.heightAnchor.constraint(equalTo:emailTextField.heightAnchor)
        passFieldHeight.isActive = true
        
    }
    
    @objc func regOrLogin()
    {
        //If login tab selected call login function
        if loginRegisterControl.selectedSegmentIndex == 0
        {
            handleLogin()
        }
        else //register new user
        {
            handleRegister()
        }
    }
    
    @objc func handleLogin()
    {
        guard let email = emailTextField.text,  let password = passwordTextField.text else{
            print("Forms cannot be blank")
            return
        }
        Auth.auth().signIn(withEmail: email, password: password) {(AuthDataResult,error) in
            if error != nil {
                print(error ?? "Something went wrong")
                emailTextField.text = ""
                passwordTextField.text = ""
                return
            }
            //otherwise everything went smooth user signed in successfully
            self.dismiss(animated: true, completion: nil)
            emailTextField.text = ""
            passwordTextField.text = ""
            self.nameFieldHeight.isActive = false
            self.emailFieldHeight.isActive = false
            self.passFieldHeight.isActive = false
        }
    }
    
    @objc func handleRegister()
    {
        guard let email = emailTextField.text,  let password = passwordTextField.text, let name = nameTextField.text else {
            print("Form is not valid")
            return
        }
        Auth.auth().createUser(withEmail: email, password: password) {(AuthDataResult, error) in
            
            if error != nil {
                print(error ?? "something went wrong")
                nameTextField.text = ""
                emailTextField.text = ""
                passwordTextField.text = ""
                return
            }
            guard let user = AuthDataResult?.user else {
                return
            }
            //otherwise we successfully created user
            let ref = Database.database().reference(fromURL: "https://gainzz-4dcf7.firebaseio.com/")
            let userRef = ref.child("users").child(user.uid)
            
            let values = ["name": name, "email": email]
            userRef.updateChildValues(values)
            emailTextField.text = ""
            nameTextField.text = ""
            passwordTextField.text = ""
            self.dismiss(animated: true, completion: nil)
            
        }
    }
    
    var containerHeight: NSLayoutConstraint!
    var nameFieldHeight: NSLayoutConstraint!
    var emailFieldHeight: NSLayoutConstraint!
    var passFieldHeight: NSLayoutConstraint!
    func setInputConstraints()
    {
        //if loginContainer.heightAnchor == 250
        
        //add x,y, width and height
        
        loginContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginContainer.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        loginContainer.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        containerHeight = loginContainer.heightAnchor.constraint(equalToConstant: 250)
        containerHeight.isActive = true
        
        loginContainer.addSubview(nameTextField)
        loginContainer.addSubview(emailTextField)
        loginContainer.addSubview(passwordTextField)
        
        nameTextField.leftAnchor.constraint(equalTo: loginContainer.leftAnchor).isActive = true
        nameTextField.topAnchor.constraint(equalTo: loginContainer.topAnchor).isActive = true
        nameTextField.widthAnchor.constraint(equalTo: loginContainer.widthAnchor).isActive = true
        nameFieldHeight = nameTextField.heightAnchor.constraint(equalTo: loginContainer.heightAnchor, multiplier: 1/3)
        nameFieldHeight.isActive = true
        nameTextField.backgroundColor = UIColor.white
        
        emailTextField.leftAnchor.constraint(equalTo: nameTextField.leftAnchor).isActive = true
        emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive = true
        emailTextField.widthAnchor.constraint(equalTo: loginContainer.widthAnchor).isActive = true
        emailFieldHeight = emailTextField.heightAnchor.constraint(equalTo: loginContainer.heightAnchor, multiplier: 1/3)
        
        emailFieldHeight.isActive = true
        emailTextField.backgroundColor = UIColor.white
        
        passwordTextField.leftAnchor.constraint(equalTo: emailTextField.leftAnchor).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: loginContainer.widthAnchor).isActive = true
        passFieldHeight = passwordTextField.heightAnchor.constraint(equalTo: loginContainer.heightAnchor, multiplier: 1/3)
        
        passFieldHeight.isActive = true
        passwordTextField.backgroundColor = UIColor.white
        
        
    }
    
    func setButtonConstraints()
    {
        loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginButton.topAnchor.constraint(equalTo: loginContainer.bottomAnchor, constant: 12).isActive = true
        loginButton.widthAnchor.constraint(equalTo: loginContainer.widthAnchor).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func setLoginImage()
    {
        loginImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginImage.bottomAnchor.constraint(equalTo: loginRegisterControl.topAnchor, constant: -12).isActive = true
        loginImage.widthAnchor.constraint(equalToConstant: 150).isActive = true
        loginImage.heightAnchor.constraint(equalToConstant: 150).isActive = true
    }
    
    func setSegmentedControl()
    {
        loginRegisterControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginRegisterControl.bottomAnchor.constraint(equalTo: loginContainer.topAnchor, constant: -12).isActive = true
        loginRegisterControl.widthAnchor.constraint(equalTo: loginContainer.widthAnchor).isActive = true
        loginRegisterControl.heightAnchor.constraint(equalToConstant: 36).isActive = true
        
    }
    
}
