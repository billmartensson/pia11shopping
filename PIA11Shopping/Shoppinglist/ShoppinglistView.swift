//
//  ShopplinglistView.swift
//  PIA11Shopping
//
//  Created by Bill Martensson on 2022-10-24.
//

import SwiftUI
import Firebase

struct ShoppinglistView: View {
    
    @State var addShopName = ""
    @State var addShopAmount = ""
    
    @StateObject var shopFixer = ShoppingCode()
    
    var body: some View {
        
        NavigationView {
            VStack {
                HStack {
                    TextField("Vad handla", text: $addShopName)
                    TextField("Antal", text: $addShopAmount)
                    
                    Button(action: {
                        shopFixer.addToShoppingList(shopname: addShopName, shopamount: addShopAmount)
                    }, label: {
                        Text("Lägg till")
                    })
                }
                
                List(shopFixer.allShopping, id: \.shopid) { shopthing in
                    
                    NavigationLink(destination: ShopdetailView(currentshop: shopthing, shopfix: shopFixer)) {
                            ShopRowView(rowshop: shopthing)
                    }
                    
                }
                
            }
            .navigationTitle("Shopping")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar() {
                Button(action: {
                    try! Auth.auth().signOut()
                }, label: {
                    Text("Logga ut")
                })
            }
            .onAppear() {
                shopFixer.loadshopping()
            }
        }
    }
    
    
}

struct ShopplinglistView_Previews: PreviewProvider {
    static var previews: some View {
        ShoppinglistView()
    }
}
