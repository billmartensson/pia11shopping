//
//  ShopplinglistView.swift
//  PIA11Shopping
//
//  Created by Bill Martensson on 2022-10-24.
//

import SwiftUI
import Firebase

struct ShoppinglistView: View {
    
    var ref: DatabaseReference! = Database.database().reference()
    
    @State var addShopName = ""
    @State var addShopAmount = ""
    
    @State var allShopping = [Shopitem]()
    
    var body: some View {
        
        NavigationView {
            VStack {
                
                
                
                HStack {
                    TextField("Vad handla", text: $addShopName)
                    TextField("Antal", text: $addShopAmount)
                    
                    Button(action: {
                        addToShoppingList()
                    }, label: {
                        Text("Lägg till")
                    })
                }
                
                List(allShopping, id: \.shopid) { shopthing in
                    
                    NavigationLink(destination: ShopdetailView(currentshop: shopthing)) {
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
                loadshopping()
            }
        }
    }
    
    func addToShoppingList() {
        if(addShopName == "")
        {
            // FEL tomt namn
            return
        }
        if(addShopAmount == "")
        {
            // FEL inget antal
            return
        }
        if(Int(addShopAmount) == nil)
        {
            // FEL inte siffra
            return
        }
        
        var userid = Auth.auth().currentUser!.uid
        
        var shopsave = [String : Any]()
        shopsave["shopname"] = addShopName
        shopsave["shopamount"] = Int(addShopAmount)
        
        ref.child("shopping").child(userid).childByAutoId().setValue(shopsave)
        
        loadshopping()
        
        addShopName = ""
        addShopAmount = ""
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
                
                
                
                allShopping.append(tempshop)
            }
            
        })
    }
}

struct ShopplinglistView_Previews: PreviewProvider {
    static var previews: some View {
        ShoppinglistView()
    }
}
