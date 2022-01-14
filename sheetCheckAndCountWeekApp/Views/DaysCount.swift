//
//  DaysCount.swift
//  sheetCheckAndCountWeekApp
//
//  Created by Shinichiro Hirasawa on 2021/10/18.
//

import SwiftUI

struct DaysCount: View {
    /// 日数計算基準日
    @State private var startDate:Date = Date()
    ///　日数計算終了日
    @State private var endDate:Date = Date()
    /// toggleのオンオフを管理するための変数
    @State private var includestartDate = false
    
    var body: some View {
        // 背景色を設定するためにZStackを設置
        ZStack {
            // 背景色の設定
            Color.customBeige
                .edgesIgnoringSafeArea(.all)
            Form {
                // 日付を選択する領域
                Section {
                    DatePicker("開始日", selection: $startDate, displayedComponents: .date)
                        .environment(\.locale, Locale(identifier: "ja_JP"))
                    
                    DatePicker("終了日", selection: $endDate, displayedComponents: .date)
                        .environment(\.locale, Locale(identifier: "ja_JP"))
                    
                    // 開始日を含むか否かのtoggleボタン
                    Toggle(isOn: $includestartDate) {
                        Text("開始日を含む")
                    }
                }  // Section
                
                // 計算結果を表示する領域
                Section{
                    HStack {
                        // 文字サイズが小さすぎるためtitle2を指定
                        Text("日数")
                            .font(.title2)
                        // 両端揃えのためにSpacerを挿入
                        Spacer()
                        // 計算結果を目立たせるために日数部分は赤字にした
                        Text("\(DateCalculator().calclateSpan(startDate: self.startDate, endDate: self.endDate, includestartDate: self.includestartDate))日")
                            .font(.title2)
                            .foregroundColor(.red)
                    } // HStack
                } // Section
            } // Form
            // 設定した背景色を有効にするためにFormのデフォルトの背景色を透明にした
            .onAppear() {
                UITableView.appearance().backgroundColor = .clear
            }
        } // ZStack
    } // body
}


struct DaysCount_Previews: PreviewProvider {
    static var previews: some View {
        DaysCount()
    }
}
