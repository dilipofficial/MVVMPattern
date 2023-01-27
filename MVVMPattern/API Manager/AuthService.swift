//
//  Auth Service.swift
//  MVVMPattern
//
//  Created by Dilip Kumar s on 13/10/22.
//

import Foundation

class AuthService: NSObject {
         
    var delegate: SignInDelegate?

   public func login(allvalue: Credentials) {
        
        guard let url = URL(string: "http://10.20.123.102:3004/api/v1/user/login") else {
            return
        }
        
        let body: [String: String] = [
            "userName" : "\(allvalue.username)",
            "password" : "\(allvalue.password)"
        
        ]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                return
                
            }
            do{
                let response = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                print(response)
                
            }catch {
                print(error)
            }
            
            self.parsingJson(data: data)
        }
        task.resume()
    }
    


public func parsingJson(data: Data){
    
    let decoder = JSONDecoder()
    
    do{
        
        let decodedata = try decoder.decode(SigninResponse.self, from: data)
        
        let statusCode = decodedata.statusCode
        
        switch statusCode {
            
        //Success
        case 200:
            token = decodedata.accessToken
            delegate?.sendingId(value: decodedata.userId)


        //Error
        case 400:
            let message = decodedata.message
            delegate?.sendingMessage(value: message)
            DispatchQueue.main.async {
               
            }
            
        default:
            print("error")
        }
    
    }catch {
        print(error)

    }
   
}
    
}
