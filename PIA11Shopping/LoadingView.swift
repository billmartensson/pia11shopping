//
//  LoadingView.swift
//  PIA11Shopping
//
//  Created by Bill Martensson on 2022-11-03.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack {
            Text("Loading...")
                .font(.largeTitle)
                .foregroundColor(Color.white)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black)
        .opacity(0.7)
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
