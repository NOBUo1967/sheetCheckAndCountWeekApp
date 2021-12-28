//
//  AfterDateCount.swift
//  sheetCheckAndCountWeekApp
//
//  Created by Shinichiro Hirasawa on 2021/12/28.
//

// commit_message:計算の基準日を入力し、取得できるようにした

import SwiftUI

struct AfterDateCount: View {
    /// 基準日
    @State private var startDate:Date = Date()
    
    var body: some View {
        Form {
            // 計算のための値を入力するSection
            Section {
                DatePicker("開始日", selection: $startDate, displayedComponents: .date)
                    .environment(\.locale, Locale(identifier: "ja_JP"))
                Text("何日後")
                Text("開始日を含む")
            } // Section
            
            // 計算結果を表示するSection
            Section {
                VStack {
                    Text("\(startDate)から")
                    Text("x日後は")
                    Text("\(startDate)")
                    
                } // VStack
            } // Section
        } // Form
    } // body
}



struct AfterDateCount_Previews: PreviewProvider {
    static var previews: some View {
        AfterDateCount()
    }
}
