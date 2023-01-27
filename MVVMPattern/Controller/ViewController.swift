//
//  ViewController.swift
//  MVVMPattern
//
//  Created by Dilip Kumar s on 13/10/22.
//

import UIKit

class ViewController: UIViewController, SignInDelegate {

    var Service = AuthService()

    var loginModel = LoginViewModel(loginManagers: LoginManager())
    
    @IBOutlet weak var userNameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
//    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var LoginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Service.delegate = self

        view.backgroundColor = .red

//        if let apikey = Bundle.main.infoDictionary?["API_key"] as? String {
//            KeyLabel.text = apikey
//            print(apikey)
        
        }
    
    @IBAction func loginAction(_ sender: UIButton) {
     
//        loginModel.updateCredentials(username: userNameTextField.text!, password: passwordTextField.text!)

        guard let userName = userNameTextField.text,
              let password = passwordTextField.text else {
                  return
              }
        
        if userName != "" , password != "" {
        
        loginModel.updateCredentials(username: userName, password: password)
//            AuthService().login(allvalue: Credentials(username: userName, password: password))

        switch loginModel.credentialsInput() {

        case.Correct:

            login()

            print("success")
        case.InCorrect:
            print("error\(LocalizedError.self)")

        default:
            return

        }
            
        }else{
            
            let alert = UIAlertController(title: "Enter username and password", message: "", preferredStyle: .alert)
            
            let action = UIAlertAction(title: "Ok", style: .destructive)
            
            alert.addAction(action)
            self.present(alert, animated: true)
            
        }
    }
    
    func login() {
        DispatchQueue.main.async {
            self.loginModel.Login()

            let NoteViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NoteViewController") as! NoteViewController

            //sending user id
//            NoteViewController.idValue = value

            self.navigationController?.pushViewController(NoteViewController, animated: true)
        }
 
    }
    
    func sendingId(value: Int?) {
        if let value = value {
                        
            let NoteViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NoteViewController") as! NoteViewController

            //sending user id
            NoteViewController.idValue = value

            self.navigationController?.pushViewController(NoteViewController, animated: true)
        }
    }
    
    func sendingMessage(value: String) {
        DispatchQueue.main.async {
            self.showToast(message: "\(value)", font: .systemFont(ofSize: 12))
            UtilityFunction().simpleAlert(vc: self, title: "\(value)", message: "")
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        self.view.endEditing(true)
        
    }
}
