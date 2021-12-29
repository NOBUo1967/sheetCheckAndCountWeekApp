//
//  AfterDateCount.swift
//  sheetCheckAndCountWeekApp
//
//  Created by Shinichiro Hirasawa on 2021/12/28.
//

// commit_message:基準日に加算するための数値を入力するkeyboardが小数点入力可能になっていたため小数点が入力できないように修正

import SwiftUI

struct AfterDateCount: View {
    /// 基準日
    @State private var startDate:Date = Date()
    /// 基準日に加算する数値
    @State private var numberOfDate:String = ""
    
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
                    Text("\(startDate)から")
                    Text("\(numberOfDate)日後は")
                    Text("\(startDate)")
                    
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
