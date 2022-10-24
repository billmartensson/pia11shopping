//
//  ShopdetailView.swift
//  PIA11Shopping
//
//  Created by Bill Martensson on 2022-10-24.
//

import SwiftUI

struct ShopdetailView: View {
    var body: some View {
        VStack {
            TextField("Vad handla", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/)
            
            TextField("Antal", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/)

            Toggle(isOn: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Is On@*/.constant(true)/*@END_MENU_TOKEN@*/) {
                Text("Köpt")
            }

            Button(action: {}, label: {
                Text("Spara")
            })

            Button(action: {}, label: {
                Text("Radera")
            })
        }
    }
}

struct ShopdetailView_Previews: PreviewProvider {
    static var previews: some View {
        ShopdetailView()
    }
}
