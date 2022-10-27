//
//  ContentView.swift
//  PIA11Shopping
//
//  Created by Bill Martensson on 2022-10-24.
//

import SwiftUI
import Firebase

struct ContentView: View {
    
    @State var isloggedin = false
    
    var body: some View {
        
        VStack {
            if(isloggedin == false)
            {
                LoginView()
            } else {
                ShoppinglistView()
            }
        }.onAppear() {
            var handle = Auth.auth().addStateDidChangeListener { auth, user in
              
                if(Auth.auth().currentUser == nil) {
                    isloggedin = false
                } else {
                    isloggedin = true
                }
            }
            
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
