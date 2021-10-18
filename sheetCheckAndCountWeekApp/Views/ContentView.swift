//
//  ContentView.swift
//  sheetCheckAndCountWeekApp
//
//  Created by Shinichiro Hirasawa on 2021/10/18.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            WeekCount()
                .tabItem {
                    Image(systemName: "calendar")
                    Text("週数計算機")
                }
            SheetCount()
                .tabItem {
                    Image(systemName: "pills.fill")
                    Text("ヒート計算機")
                }
            
        } // TabView
        .accentColor(.red)
    } // body
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
