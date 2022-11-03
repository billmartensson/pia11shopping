//
//  LoginCode.swift
//  PIA11Shopping
//
//  Created by Bill Martensson on 2022-11-03.
//

import Foundation
import Firebase

class LoginCode : ObservableObject {
    
    @Published var showerror = false
        
    func dummycode() {
        
    }
    
    func loginuser(useremail : String, userpassword : String) {
        Auth.auth().signIn(withEmail: useremail, password: userpassword) { authResult, error in
          
            if(error != nil)
            {
                // Misslyckad inloggning
                self.showerror = true
            }

        }
    }
    
    func registeruser(useremail : String, userpassword : String) {
        Auth.auth().createUser(withEmail: useremail, password: userpassword) { authResult, error in
            
            print(error)
            
            if(error != nil)
            {
                // Misslyckad registering
                self.showerror = true
            }
        }
    }
    
    
}
