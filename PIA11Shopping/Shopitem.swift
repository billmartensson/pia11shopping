//
//  Shopitem.swift
//  PIA11Shopping
//
//  Created by Bill Martensson on 2022-10-27.
//

import Foundation
import Firebase

class Shopitem {
    var shopid = ""
    var shopname = "Banan"
    var shopamount = 45
    var shopbought = false
    
    
    func hejkoden() -> String {
        return "Tjena"
    }
    
    func boughtInfoText() -> String {
        if(shopbought == true)
        {
            return "Köpt"
        } else {
            return "Ej köpt"
        }
    }
    
    
    func deleteme() {
        var ref: DatabaseReference! = Database.database().reference()
        
        var userid = Auth.auth().currentUser!.uid
        
        ref.child("shopping").child(userid).child(shopid).removeValue()
    }
    
    
}
