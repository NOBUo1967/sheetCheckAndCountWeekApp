//
//  AfterDateCount.swift
//  sheetCheckAndCountWeekApp
//
//  Created by Shinichiro Hirasawa on 2021/12/28.
//

// commit_message: 

import SwiftUI

struct AfterDateCount: View {
    /// 基準日
    @State private var startDate: Date = Date()
    /// 基準日に加算する数値
    @State private var numberOfDate: String = ""
    /// 加算後の日付
    @State private var dateAfterAddition:Date = Date()
    /// toggleのオンオフを管理するための変数
    // toggleのフラグ変数の方がBinding型のためState変数として宣言
    @State private var includestartDate = false
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
            // 計算のための値を入力するSection
            Section {
                // 基準日を入力する部分
                DatePicker("開始日", selection: self.$startDate, displayedComponents: .date)
                    .environment(\.locale, Locale(identifier: "ja_JP"))
                // 加算する日数の入力部分
                HStack {
                    // TextFieldのラベルとしてTextを設置
                    Text("何日後")
                    // 両端揃えにするためにSpacerを設置
                    Spacer()
                    // 日数入力部分
                    TextField("日後", text: self.$numberOfDate)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.numberPad)
                        // DatePickerと同じ幅にするためにwidth:110とした
                        .frame(width: 110, height: 30)
                } // HStack
                // 開始日を含むか否かのToggle
                Toggle(isOn: $includestartDate) {
                    Text("開始日を含む")
                }
                
                // 日数計算のbutton
                HStack {
                    // Buttonを右端に寄せるためにSpacerを追加
                    Spacer()
                    Button(action: {
                        //　日数計算のためのカレンダーを定義
                        let calender = Calendar(identifier:.gregorian)
                        // 入力された日数はStr型であり、if let文でnilチェックするためInt?型にキャストする
                        let addDate: Int? = Int(self.numberOfDate)
                        // 入力された日数のnilチェック。0は入力されうるためチェックしない
                        if var addDate = addDate {
                            // 開始日を含むか否かのtoggleがonのときは加算する日数を-1する
                            if includestartDate == true {
                                addDate -= 1
                            }
                            // 計算部分
                            self.dateAfterAddition = calender.date(byAdding: .day, value: addDate, to: self.startDate)!
                        } else {
                            // nilの場合はアラートを表示する
                            showAlert = true
                        }
                    }) {
                        Text("計算")
                            .frame(minWidth: 90, alignment: .center)
                    } // Button
                    // Form内のButtonが正常に動作しないためbuttonStyleを削除する際は注意
                    .buttonStyle(PrimaryButtonStyle())
                }
            } // Section
            
            // 計算結果を表示するSection
            Section {
                VStack {
                    Text("\(startDate, formatter: dateFormat)から")
                    Text("\(numberOfDate)日後は")
                    Text("\(dateAfterAddition,formatter: dateFormat)")
                } // VStack
                // Sction内のVStackの要素がTextの幅と同値であったためmaxWidthをinfinityとし、その上でcenterで中央寄せにした
                .frame(maxWidth:.infinity, alignment: .center)
                .font(.title3)
            } // Section
        } // Form
        // keyboard外をタップするとkeyboardを閉じる処理
        .onTapGesture {
            UIApplication.shared.closeKeyboard()
        }
        // Alert部分
        .alert(isPresented: $showAlert) {
            Alert(title: Text("正しい値を入力してください"), message: Text("何日後には0以上の数字を入力してください"), dismissButton: .default(Text("OK")))
        }
    } // body
}

struct AfterDateCount_Previews: PreviewProvider {
    static var previews: some View {
        AfterDateCount()
    }
}
