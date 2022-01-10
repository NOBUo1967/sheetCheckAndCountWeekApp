//
//  LeftoverMedicineCount.swift
//  sheetCheckAndCountWeekApp
//
//  Created by Shinichiro Hirasawa on 2022/01/06.
//

// commit_message: 計算実行のためのbuttonを配置する

import SwiftUI

struct LeftoverMedicineCount: View {
    /// 内服開始日
    @State private var startDate: Date = Date()
    /// 処方日数。TextFieldから入力値を受け取るためString型にする
    @State private var prescriptionDays: String = ""
    /// 中断日
    @State private var interruptionDate: Date = Date()
    
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
                DatePicker("内服開始日", selection: self.$startDate, displayedComponents: .date)
                    .environment(\.locale, Locale(identifier: "ja_JP"))
                // 処方日数入力部分
                HStack {
                    // TextFieldのラベルとしてTextを設置
                    Text("処方日数")
                    // 両端揃えにするためにSpacerを設置
                    Spacer()
                    // 日数入力部分
                    TextField("日分", text: self.$prescriptionDays)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.numberPad)
                        // DatePickerと同じ幅にするためにwidth:110とした
                        .frame(width: 110, height: 30)
                } // HStack
                // 中断日の入力
                DatePicker("中断日", selection: self.$interruptionDate, displayedComponents: .date)
                    .environment(\.locale, Locale(identifier: "ja_JP"))
                // 計算ボタン
                HStack {
                    // Buttonを右端寄せにするためにSpacerを設置した
                    Spacer()
                    Button(action: {
                        print("test")
                    // 処方日数に不正な値が入力される、もしくは開始日と中断日がマイナスになった際にアラートを表示する
//                    } else {
//                            print("test")
//                        }
                    }) {
                        Text("計算")
                    } //Button
                    .buttonStyle(PrimaryButtonStyle())
                } // HStack
            } // Section
            
            Section {
                Text("\(startDate, formatter: dateFormat)")
                Text("\(prescriptionDays)日分")
                Text("\(interruptionDate, formatter: dateFormat)")
            } // Section
        }// Form
    } // body
}

struct LeftoverMedicineCount_Previews: PreviewProvider {
    static var previews: some View {
        LeftoverMedicineCount()
    }
}
