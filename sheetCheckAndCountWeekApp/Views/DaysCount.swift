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
                    Text("\(calclateSpan(startDate: self.startDate, endDate: self.endDate))日")
                        .font(.title2)
                        .foregroundColor(.red)
                    
                    // TODO: トグルボタンの値が反映されているか確認するための文字列。動作確認できたら削除する
                    Text(includestartDate ? "オンです" : "オフです")
                } // HStack
            } // Section
        } // Form
    } // body
    
    
    // 指定した日付の時間をリセットする関数
    // 0401 23:59と0402 0:00のようなケースでは計算がうまく行かないため実装
    func resetTime(date: Date) -> Date {
        let calendar: Calendar = Calendar(identifier: .gregorian)
        var components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        
        components.hour = 0
        components.minute = 0
        components.second = 0
        
        return calendar.date(from: components)!
    }
    
    // 日付の差を計算する関数
    func calclateSpan(startDate: Date, endDate: Date) -> Int {
        // 入力値の時間をリセット
        let resetTimeStartDate = resetTime(date: startDate)
        let resteTImeEndDate = resetTime(date: endDate)
        
        // 計算部分 TimeIntervalがDouble型のため差spanはDouble型で宣言
        let span:Double = resteTImeEndDate.timeIntervalSince(resetTimeStartDate)
        // TimeIntervalが秒数で与えられるため(60秒*60分*24時間)で除算して日数へ変換
        // 計算結果が1日分少ないため1を足している
        let differenceInTheNumberOfDays = span/(60*60*24) + 1
        
        return Int(differenceInTheNumberOfDays)
    }
}


struct DaysCount_Previews: PreviewProvider {
    static var previews: some View {
        DaysCount()
    }
}
