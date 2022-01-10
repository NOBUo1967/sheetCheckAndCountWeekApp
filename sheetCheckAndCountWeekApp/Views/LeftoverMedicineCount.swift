//
//  LeftoverMedicineCount.swift
//  sheetCheckAndCountWeekApp
//
//  Created by Shinichiro Hirasawa on 2022/01/06.
//

// commit_message: 計算結果が合わないため修正

import SwiftUI

struct LeftoverMedicineCount: View {
    /// 内服開始日
    @State private var startDate: Date = Date()
    /// 処方日数。TextFieldから入力値を受け取るためString型にする
    @State private var prescriptionDays: String = ""
    /// 中断日
    @State private var interruptionDate: Date = Date()
    /// toggleのオンオフを管理するための変数
    @State private var includestartDate = false
    /// 残薬の日数
    @State private var numberOfDaysLeftoverMedicines: Int = 0
    /// アラート表示のための状態変数
    @State private var showAlert: Bool = false
    
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
                
                // 開始日を含むか否かのtoggleボタン
                Toggle(isOn: $includestartDate) {
                    Text("開始日を含む")
                }
                
                // 計算ボタン
                HStack {
                    // Buttonを右端寄せにするためにSpacerを設置した
                    Spacer()
                    // 残薬計算ボタン
                    Button(action: {
                        // 入力された処方日数はString型のためキャスト。後にif let文でnilチェックするためInt?型にする
                        let prescriptionDays: Int? = Int(self.prescriptionDays)
                        // 内服開始日と内服中断日の差を計算
                        let dateSpan: Int = DateCalculator().calclateSpan(startDate: self.startDate, endDate: self.interruptionDate, includestartDate: self.includestartDate)
                        // 処方日数のnilチェック。0は入力されうるためチェックしない
                        if let prescriptionDays = prescriptionDays {
                            // 内服開始日を含めるため残り日数は-1になる
                            numberOfDaysLeftoverMedicines = prescriptionDays - dateSpan - 1
                        } else {
                            // 処方日数に値が入力されていない場合はアラートを表示する
                            showAlert = true
                        }
                    }) {
                        Text("計算")
                    } //Button
                    .buttonStyle(PrimaryButtonStyle())
                } // HStack
            } // Section
            
            Section {
                VStack {
                    Text("\(startDate, formatter: dateFormat)から")
                    Text("\(interruptionDate, formatter: dateFormat)まで内服している場合")
                    Text(numberOfDaysLeftoverMedicines >= 0 ? "残薬は\(numberOfDaysLeftoverMedicines)日分あると考えられます" : "test")
                } // VStack
            } // Section
        }// Form
        // keyboard外をタップするとkeyboardを閉じる処理
        .onTapGesture {
            UIApplication.shared.closeKeyboard()
        }
        // Alert部分
        .alert(isPresented: $showAlert) {
            Alert(title: Text("正しい値を入力してください"), message: Text("処方日数には0以上の数字を入力してください"), dismissButton: .default(Text("OK")))
        }
    } // body
}

struct LeftoverMedicineCount_Previews: PreviewProvider {
    static var previews: some View {
        LeftoverMedicineCount()
    }
}
