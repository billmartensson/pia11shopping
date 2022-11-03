//
//  LoginView.swift
//  PIA11Shopping
//
//  Created by Bill Martensson on 2022-10-24.
//

import SwiftUI

struct LoginView: View {
    
    @State var loginemail = ""
    @State var loginpassword = ""
    
    @StateObject var loginFixer = LoginCode()
    
    var body: some View {
        
        ZStack {
            VStack {
                Text("Logga in!!")
                    .font(.largeTitle)
                Spacer()
                
                if(loginFixer.errorRegister)
                {
                    Text("Felaktig registrering")
                        .font(.title)
                        .foregroundColor(Color.white)
                        .padding()
                        .background(.red)
                }
                
                TextField("E-post", text: $loginemail)
                    .keyboardType(.emailAddress)
                SecureField("Lösenord", text: $loginpassword)

                HStack {
                    Button(action: {
                        
                        loginFixer.registeruser(useremail: loginemail, userpassword: loginpassword)
                        
                    }, label: {
                        Text("Registrera")
                            .padding()
                    })
                    Button(action: {
                        loginFixer.loginuser(useremail: loginemail, userpassword: loginpassword)
                    }, label: {
                        Text("Logga in")
                            .padding()
                    })
                }
            }
            
            if(loginFixer.isLoading)
            {
                LoadingView()
            }
        }
        .padding()
        .alert("Det blev fel", isPresented: $loginFixer.showerror) {
            Button("OK") { }
        }
    }
    
    
    
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
