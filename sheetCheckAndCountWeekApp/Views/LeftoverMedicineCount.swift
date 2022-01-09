//
//  LeftoverMedicineCount.swift
//  sheetCheckAndCountWeekApp
//
//  Created by Shinichiro Hirasawa on 2022/01/06.
//

// commit_message:処方日を入力できる

import SwiftUI

struct LeftoverMedicineCount: View {
    /// 基準日
    @State private var startDate: Date = Date()
    
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
            Section {
                // 処方日の入力
                DatePicker("処方日", selection: self.$startDate, displayedComponents: .date)
                    .environment(\.locale, Locale(identifier: "ja_JP"))
            } // Section
            
            Section {
                Text("\(startDate, formatter: dateFormat)")
            } // Section
        }// Form
    } // body
}

struct LeftoverMedicineCount_Previews: PreviewProvider {
    static var previews: some View {
        LeftoverMedicineCount()
    }
}
