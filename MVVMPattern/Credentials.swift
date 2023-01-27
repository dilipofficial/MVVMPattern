//
//  Credentials.swift
//  MVVMPattern
//
//  Created by Dilip Kumar s on 13/10/22.
//

import Foundation

public var token: String?

struct Credentials {
    
    var username: String = ""
    var password: String = ""
    
}

struct SigninResponse: Codable {
    
    var accessToken: String?
    var message: String
    var statusCode: Int
    var userId: Int?
    
}

struct LoginManager {
    
    func loginWithCredentials(username: String, password: String) {
        AuthService().login(allvalue: Credentials(username: username, password: password))
        
       }
}
    
protocol SignInDelegate{
    
    func sendingId (value: Int?)
    func sendingMessage (value: String)
    
     }
