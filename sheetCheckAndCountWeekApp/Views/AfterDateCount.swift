//
//  AfterDateCount.swift
//  sheetCheckAndCountWeekApp
//
//  Created by Shinichiro Hirasawa on 2021/12/28.
//

// commit_message:表示する日付をyyyy年mm月dd日にするためにformatを定義した

import SwiftUI

struct AfterDateCount: View {
    /// 基準日
    @State private var startDate:Date = Date()
    /// 基準日に加算する数値
    @State private var numberOfDate:String = ""
    
    /// 日数表示のフォーマット
    var dateFormat: DateFormatter {
        let format = DateFormatter()
        // 曜日表示はいらないためlongを指定
        format.dateStyle = .long
        // 時刻は表示しないためnoneを指定
        format.timeStyle = .none
        
        format.locale = Locale(identifier: "ja_JP")
        format.calendar = Calendar(identifier: .japanese)
        // formatはyyyy年mm月dd日としたかったため下記のテンプレートを使用
        format.dateFormat = DateFormatter.dateFormat(fromTemplate: "yMMMd", options: 0, locale: Locale(identifier: "ja_JP"))
        return format
    }
    
    
    var body: some View {
        Form {
            // 計算のための値を入力するSection
            Section {
                DatePicker("開始日", selection: $startDate, displayedComponents: .date)
                    .environment(\.locale, Locale(identifier: "ja_JP"))
                TextField("日後", text: self.$numberOfDate)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.numberPad)
                    .frame(width: 120, height: 30, alignment: .trailing)
                Text("開始日を含む")
            } // Section
            
            // 計算結果を表示するSection
            Section {
                VStack {
                    Text("\(startDate, formatter: dateFormat)から")
                    Text("\(numberOfDate)日後は")
                    Text("\(startDate,formatter: dateFormat)")
                    
                } // VStack
            } // Section
        } // Form
        // keyboard外をタップするとkeyboardを閉じる処理
        .onTapGesture {
            UIApplication.shared.closeKeyboard()
        }
    } // body
}



struct AfterDateCount_Previews: PreviewProvider {
    static var previews: some View {
        AfterDateCount()
    }
}
