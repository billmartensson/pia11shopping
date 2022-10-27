//
//  ShopdetailView.swift
//  PIA11Shopping
//
//  Created by Bill Martensson on 2022-10-24.
//

import SwiftUI
import Firebase

struct ShopdetailView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var ref: DatabaseReference! = Database.database().reference()
    
    @State var currentshop : Shopitem
    
    @State var shopname = ""
    @State var shopamount = ""
    @State var havebought = false
    
    var body: some View {
        VStack {
            TextField("Vad handla", text: $shopname)
            
            TextField("Antal", text: $shopamount)

            Toggle(isOn: $havebought) {
                Text("Köpt")
            }.onChange(of: havebought) { value in
                saveshop()
            }

            Button(action: {
                saveshop()
            }, label: {
                Text("Spara")
            })

            Button(action: {
                deleteshop()
            }, label: {
                Text("Radera")
            })
        }
        .navigationTitle(shopname)
        .onAppear() {
            shopname = currentshop.shopname
            shopamount = String(currentshop.shopamount)
            havebought = currentshop.shopbought
            
        }
    }
    
    func saveshop() {
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
        
        ref.child("shopping").child(userid).child(currentshop.shopid).setValue(shopsave)
        
    }
    
    func deleteshop() {
        currentshop.deleteme()
        
        dismiss()
    }
}

struct ShopdetailView_Previews: PreviewProvider {
    static var previews: some View {
        ShopdetailView(currentshop: Shopitem())
    }
}
