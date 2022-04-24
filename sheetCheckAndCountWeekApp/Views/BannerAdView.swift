//
//  BannerAdView.swift
//  sheetCheckAndCountWeekApp
//
//  Created by Shinichiro Hirasawa on 2022/01/17.
//

import SwiftUI
import GoogleMobileAds

struct BannerAdView: UIViewRepresentable {
    func makeUIView(context: Context) -> GADBannerView {
        let banner = GADBannerView(adSize: GADAdSizeBanner)
        banner.adUnitID = {adMobKey} // adMob広告IDを取得して入力
        banner.rootViewController = UIApplication.shared.windows.first?.rootViewController
        banner.load(GADRequest())
        return banner
    }
    
    func updateUIView(_ uiView: GADBannerView, context: Context) {
    }
}
