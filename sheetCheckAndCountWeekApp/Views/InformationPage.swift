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
                    Text("計算結果には細心の注意を払って\n開発をしていますが、\n計算に間違いがあった場合や\n入力間違いによって生じた損害に対し、\n当方は一切責任を負いかねますので\nあらかじめご了承ください。")
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
