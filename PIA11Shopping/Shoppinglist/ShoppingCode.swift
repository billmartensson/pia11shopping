//
//  ShoppingCode.swift
//  PIA11Shopping
//
//  Created by Bill Martensson on 2022-11-03.
//

import Foundation
import Firebase

class ShoppingCode : ObservableObject {
    
    var ref: DatabaseReference! = Database.database().reference()
    
    @Published var allShopping = [Shopitem]()
    
    
    func addToShoppingList(shopname : String, shopamount : String) {
        if(shopname == "")
        {
            // FEL tomt namn
            return
        }
        if(shopamount == "")
        {
            // FEL inget antal
            return
        }
        if(Int(shopamount) == nil)
        {
            // FEL inte siffra
            return
        }
        
        var userid = Auth.auth().currentUser!.uid
        
        var shopsave = [String : Any]()
        shopsave["shopname"] = shopname
        shopsave["shopamount"] = Int(shopamount)
        
        ref.child("shopping").child(userid).childByAutoId().setValue(shopsave)
        
        loadshopping()
        
        //addShopName = ""
        //addShopAmount = ""
    }
    
    func loadshopping() {
        
        allShopping = []
        
        let userid = Auth.auth().currentUser!.uid
        
        ref.child("shopping").child(userid).getData(completion:  { error, snapshot in
            
            for shopdata in snapshot!.children {
                
                let shopsnap = shopdata as! DataSnapshot
                
                let shopdict = shopsnap.value as! [String : Any]
                let shopid = shopsnap.key
                
                let tempshop = Shopitem()
                tempshop.shopid = shopid
                tempshop.shopname = shopdict["shopname"] as! String
                tempshop.shopamount = shopdict["shopamount"] as! Int

                if let checkbought = shopdict["shopbought"] as? Bool {
                    tempshop.shopbought = checkbought
                }
                
                
                
                self.allShopping.append(tempshop)
            }
            
        })
    }
    
    func saveshop(shopthing : Shopitem, shopname : String, shopamount : String, havebought : Bool) {
        if(shopname == "")
        {
            // FEL tomt namn
            return
        }
        if(shopamount == "")
        {
            // FEL inget antal
            return
        }
        if(Int(shopamount) == nil)
        {
            // FEL inte siffra
            return
        }
        
        
        var userid = Auth.auth().currentUser!.uid
        
        var shopsave = [String : Any]()
        shopsave["shopname"] = shopname
        shopsave["shopamount"] = Int(shopamount)
        shopsave["shopbought"] = havebought
        
        ref.child("shopping").child(userid).child(shopthing.shopid).setValue(shopsave)
        
    }
    
    func deleteshop(shopthing : Shopitem) {
        var ref: DatabaseReference! = Database.database().reference()
        
        var userid = Auth.auth().currentUser!.uid
        
        ref.child("shopping").child(userid).child(shopthing.shopid).removeValue()
        
        //dismiss()
    }
    
    
}
