//
//  LoginView.swift
//  PIA11Shopping
//
//  Created by Bill Martensson on 2022-10-24.
//

import SwiftUI
import Firebase

struct LoginView: View {
    
    @State var loginemail = ""
    @State var loginpassword = ""
    
    @State var showerror = false
    
    var body: some View {
        VStack {
            Text("Logga in!!")
                .font(.largeTitle)
            Spacer()
            
            TextField("E-post", text: $loginemail)
                .keyboardType(.emailAddress)
            SecureField("Lösenord", text: $loginpassword)

            HStack {
                Button(action: {
                    registeruser()
                }, label: {
                    Text("Registrera")
                        .padding()
                })
                Button(action: {
                    loginuser()
                }, label: {
                    Text("Logga in")
                        .padding()
                })
            }
        }
        .padding()
        .alert("Det blev fel", isPresented: $showerror) {
            Button("OK") { }
        }
    }
    
    func loginuser() {
        Auth.auth().signIn(withEmail: loginemail, password: loginpassword) { authResult, error in
          
            if(error != nil)
            {
                // Misslyckad inloggning
                showerror = true
            }

        }
    }
    
    func registeruser() {
        Auth.auth().createUser(withEmail: loginemail, password: loginpassword) { authResult, error in
            
            print(error)
            
            if(error != nil)
            {
                // Misslyckad registering
                showerror = true
            }
        }
    }
    
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
