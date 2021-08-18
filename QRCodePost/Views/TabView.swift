//
//  TabView.swift
//  QRCodePost
//
//  Created by Genuine on 13.08.2021.
//

import SwiftUI

struct BottomBar: View {
    var body: some View {
        TabView {
           RedView()
             .tabItem {
                Image(systemName: "phone.fill")
                Text("First Tab")
              }

           BlueView()
             .tabItem {
                Image(systemName: "tv.fill")
                Text("Second Tab")
              }
        }
    }
}

struct RedView: View {
    var body: some View {
        Color.red
    }
}

struct BlueView: View {
    var body: some View {
        Color.blue
    }
}

struct BottomBar_Previews: PreviewProvider {
    static var previews: some View {
        BottomBar()
    }
}
