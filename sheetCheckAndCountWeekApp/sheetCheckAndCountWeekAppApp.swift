//
//  sheetCheckAndCountWeekAppApp.swift
//  sheetCheckAndCountWeekApp
//
//  Created by Shinichiro Hirasawa on 2021/10/18.
//

import SwiftUI
// AdMobを導入
import UIKit
import GoogleMobileAds

// ApDelegateクラスの定義
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLanchingWithOptions lanchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        // Mobile_Ads_SDKの初期化
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        return true
    }
}

@main
struct sheetCheckAndCountWeekAppApp: App {
    // SwiftUIのライフサイクルにAppDelegateクラスを追加
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
