//
//  InformationPage.swift
//  sheetCheckAndCountWeekApp
//
//  Created by Shinichiro Hirasawa on 2022/01/17.
//

import SwiftUI

struct InformationPage: View {
    var body: some View {
        // 背景色を設定するためにZStackを設置
        ZStack {
            // 背景色の設定
            Color.customBeige
                .edgesIgnoringSafeArea(.all)
            Form {
                Section {
                    HStack {
                        Text("バージョン")
                        Spacer()
                        Text("1.0")
                    }
                    
                    HStack {
                        Text("作者")
                        Spacer()
                        Text("NOBUo")
                    }
                } header: {
                    Text("このアプリについて")
                } // Section
                
                Section {
                    Text("計算結果には細心の注意を払って開発をしていますが、計算に間違いがあった場合や入力間違いによって生じた損害に対し、当方は一切責任を負いかねますのであらかじめご了承ください。")
                } header: {
                    Text("免責事項")
                } footer: {
                    Text("2022年1月17日 策定")
                }//Section
            } // Form
        } // ZStack
    } // body
}


struct InformationPage_Previews: PreviewProvider {
    static var previews: some View {
        InformationPage()
    }
}
