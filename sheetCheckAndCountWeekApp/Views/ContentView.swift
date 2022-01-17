//
//  ContentView.swift
//  sheetCheckAndCountWeekApp
//
//  Created by Shinichiro Hirasawa on 2021/10/18.
//

import SwiftUI

struct ContentView: View {
    
    // tabViewの色を設定
    init() {
        UITabBar.appearance().unselectedItemTintColor = UIColor(Color.tabIconBrown)
    }
    
    var body: some View {
        VStack {
            TabView {
                DaysCount()
                    .tabItem {
                        Image(systemName: "calendar")
                        Text("日数計算")
                    }
                AfterDateCount()
                    .tabItem {
                        Image(systemName: "calendar.badge.plus")
                        Text("何日後はいつ")
                    }
                SheetCount()
                    .tabItem {
                        Image(systemName: "pills.fill")
                        Text("ヒート数計算")
                    }
                
                LeftoverMedicineCount()
                    .tabItem {
                        if #available(iOS 15.0, *) {
                            Image(systemName: "pills.circle")
                        } else {
                            Image(systemName: "pills")
                        }
                        Text("残薬計算")
                    }
                InformationPage()
                    .tabItem {
                        Image(systemName: "info.circle")
                        Text("このアプリについて")
                    }
                
            } // TabView
            .accentColor(.red)
            // Banner広告を表示する
            BannerAdView().frame(width: 320, height: 50)
        } // VStack
    } // body
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
