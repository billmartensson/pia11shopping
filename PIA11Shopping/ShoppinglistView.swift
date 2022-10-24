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
    
    @State var shoplistIds = [String]()
    @State var shoplistNames = [String]()
    @State var shoplistAmount = [Int]()

    var body: some View {
        
        NavigationView {
            VStack {
                
                Button(action: {
                    try! Auth.auth().signOut()
                }, label: {
                    Text("Logga ut")
                })
                
                HStack {
                    TextField("Vad handla", text: $addShopName)
                    TextField("Antal", text: $addShopAmount)
                    
                    Button(action: {
                        addToShoppingList()
                    }, label: {
                        Text("Lägg till")
                    })
                }
                
                List {
                    ForEach(Array(shoplistIds.enumerated()), id: \.element) { index, rowfruit in
                        
                        HStack {
                            Text(shoplistNames[index])
                            Text(String(shoplistAmount[index]))
                        }
                    }
                }
            }.onAppear() {
                loadshopping()
            }
        }
    }
    
    func addToShoppingList() {
        var userid = Auth.auth().currentUser!.uid
        
        var shopsave = [String : Any]()
        shopsave["shopname"] = addShopName
        shopsave["shopamount"] = Int(addShopAmount)
        
        ref.child("shopping").child(userid).childByAutoId().setValue(shopsave)
        
        loadshopping()
    }
    
    func loadshopping() {
        
        shoplistIds = []
        shoplistNames = []
        shoplistAmount = []

        var userid = Auth.auth().currentUser!.uid
        
        ref.child("shopping").child(userid).getData(completion:  { error, snapshot in
            
            for shopdata in snapshot!.children {
                
                let shopsnap = shopdata as! DataSnapshot
                
                let shopdict = shopsnap.value as! [String : Any]
                let shopid = shopsnap.key
                
                shoplistIds.append(shopid)
                
                shoplistNames.append(shopdict["shopname"] as! String)
                shoplistAmount.append(shopdict["shopamount"] as! Int)

            }
            
        })
    }
}

struct ShopplinglistView_Previews: PreviewProvider {
    static var previews: some View {
        ShoppinglistView()
    }
}
