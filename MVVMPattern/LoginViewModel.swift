//
//  LoginViewModel.swift
//  MVVMPattern
//
//  Created by Dilip Kumar s on 13/10/22.
//

import Foundation

class LoginViewModel: NSObject {
    
     var loginManager = LoginManager()

     var credentials = Credentials() {
        didSet{
            username = credentials.username
            password = credentials.password
        }
    }
    
    private var username = ""
    private var password = ""
    
    init(loginManagers: LoginManager) {
        self.loginManager = loginManagers
    }
    
    
     func updateCredentials(username: String, password: String) {
        credentials.username = username
        credentials.password = password
    }
    
    func Login() {
        loginManager.loginWithCredentials(username: username, password: password)
    }
    
    func credentialsInput() -> CredentialsInputStatus {
        
        if username.isEmpty && password.isEmpty {
            return .InCorrect
        }
        if username.isEmpty {
            return.InCorrect
        }
        if password.isEmpty{
            return.InCorrect
        }
        return.Correct
        
    }

}

extension LoginViewModel {
    
    enum CredentialsInputStatus {
        case Correct
        case InCorrect
    }
    
}
