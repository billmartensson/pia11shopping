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
    
    @ObservedObject var shopfix : ShoppingCode
    
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
                shopfix.saveshop(shopthing: <#T##Shopitem#>, shopname: <#T##String#>, shopamount: <#T##String#>, havebought: <#T##Bool#>)
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
    
    
}

struct ShopdetailView_Previews: PreviewProvider {
    static var previews: some View {
        ShopdetailView(currentshop: Shopitem(), shopfix: ShoppingCode())
    }
}
