//
//  ShopRowView.swift
//  PIA11Shopping
//
//  Created by Bill Martensson on 2022-10-27.
//

import SwiftUI

struct ShopRowView: View {
    
    @State var rowshop : Shopitem
    
    var body: some View {
        VStack {
            HStack {
                Text(rowshop.shopname)
                Text(String(rowshop.shopamount))
                Spacer()
            }.padding()
            
            Text(rowshop.boughtInfoText())
        }
    }
}

struct ShopRowView_Previews: PreviewProvider {
    static var previews: some View {
        ShopRowView(rowshop: Shopitem())
            .previewLayout(.sizeThatFits)
    }
}
