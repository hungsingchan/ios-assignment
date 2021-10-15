//
//  ContentView.swift
//  Shared
//
//  Created by xdeveloper on 15/10/2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
                    HomeView().tabItem {
//                        Image(systemName: "info.circle.fill")
                        Text("Home")
                    }
                    
                    MallsView().tabItem {
//                        Image(systemName: "calendar.circle.fill")
                        Text("Malls")
                    }
                    
                    CoinsView().tabItem {
//                        Image(systemName: "calendar.circle.fill")
                        Text("Coins")
                    }
                    
                    UserView().tabItem {
//                        Image(systemName: "map.fill")
                        Text("User")
                    }
                    
                }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        
    }
}
