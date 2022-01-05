//
//  ButtonStyle.swift
//  sheetCheckAndCountWeekApp
//
//  Created by Shinichiro Hirasawa on 2022/01/05.
//

// commit_message:ButtonStyleを定義する

import SwiftUI

struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 90, alignment: .center)
            .padding()
            .background(Color.red)
            .foregroundColor(Color.white)
            .font(.body.bold())
            .cornerRadius(10)
    }
}
