//
//  SwiftUIViewTabBar.swift
//  finalprojectiospart
//
//  Created by Айбек on 23.05.2022.
//

import SwiftUI

struct NewsView: View {
    var body: some View {
            ZStack {
                NewsListView()
            }
            .navigationTitle("NPA App")
    }
}


struct AccountView: View {
    var body: some View {
            ZStack {
                SwiftUIViewAccount()
            }
            .navigationTitle("NPA App")
    }
}

struct MapView: View {
    var body: some View{
            ZStack {
                //SwiftUIViewMap()
                Image("dark")
            }
            .navigationTitle("NPA App")
    }
}

struct SwiftUIViewTabBar: View {
    var body: some View {
        TabView {
            NewsView()
                .tabItem {
                    Image("Newspaper")
                        .frame(width: 25, height: 25)
                    Text("News")
                }
            
            AccountView()
                .tabItem {
                    Image("Gear")
                        .frame(width: 25, height: 25)
                    Text("Account")
                }
            
            MapView()
                .tabItem {
                    Image("Map")
                        .frame(width: 25, height: 25)
                    Text("Map")
                }
        }
    }
}

struct SwiftUIViewTabBar_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIViewTabBar()
    }
}
