//
//  ButtonStyle.swift
//  sheetCheckAndCountWeekApp
//
//  Created by Shinichiro Hirasawa on 2022/01/05.
//

// commit_message:ButtonStyleに押下時のアニメーションを設定した

import SwiftUI

struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        //　押下しているか否かで動作を分けるための変数
        let isPressed = configuration.isPressed
        
        configuration.label
            .frame(width: 90, alignment: .center)
            .padding()
            .background(Color.red)
            .foregroundColor(Color.white)
            .font(.body.bold())
            .cornerRadius(10)
        // 押下時のボタンの見た目を変更
            .scaleEffect(x: isPressed ? 0.9 : 1 , y: isPressed ? 0.9 : 1, anchor: .center)
            .opacity(isPressed ? 0.3 : 1)
        // 押下時のアニメーション
            .animation(.default)
    }
}
