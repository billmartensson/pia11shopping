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
    
    @Published var errorRegister = false
    
    @Published var isLoading = false
    
    func dummycode() {
        
    }
    
    func loginuser(useremail : String, userpassword : String) {
        isLoading = true
        Auth.auth().signIn(withEmail: useremail, password: userpassword) { authResult, error in
            self.isLoading = false
            if(error != nil)
            {
                // Misslyckad inloggning
                self.showerror = true
            }

        }
    }
    
    func registeruser(useremail : String, userpassword : String) {
        isLoading = true
        Auth.auth().createUser(withEmail: useremail, password: userpassword) { authResult, error in
            self.isLoading = false
            print(error)
            
            if(error != nil)
            {
                // Misslyckad registering
                self.errorRegister = true
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.errorRegister = false
                }
            }
        }
    }
    
    
}
