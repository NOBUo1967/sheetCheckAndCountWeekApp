//
//  LeftoverMedicineCount.swift
//  sheetCheckAndCountWeekApp
//
//  Created by Shinichiro Hirasawa on 2022/01/06.
//

// commit_message: 中断日が内服開始日より前の日付だった場合はアラートを表示する

import SwiftUI

/// アラートを出し分けるための列挙体の定義
enum AlertType {
    // 入力値が誤っている場合のアラート
    case incorrectInputValue
    // 中断日が処方開始日より前の日付だった場合のアラート
    case incorrectSelectedDate
    // 薬不足の場合のアラート
    case runOutMedicine
}

struct LeftoverMedicineCount: View {
    /// 内服開始日
    @State private var startDate: Date = Date()
    /// 処方日数。TextFieldから入力値を受け取るためString型にする
    @State private var prescriptionDays: String = ""
    /// 中断日
    @State private var interruptionDate: Date = Date()
    /// 残薬の日数
    @State private var numberOfDaysLeftoverMedicines: Int = 0
    /// アラート表示のための状態変数
    @State private var showAlert: Bool = false
    /// アラートの出し分けのための変数。初期値は入力値の誤りとしておく
    @State private var alertType: AlertType = .incorrectInputValue
    
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
        // 背景色を設定するためにZStackを設置
        ZStack {
            // 背景色の設定
            Color.customBeige
                .edgesIgnoringSafeArea(.all)
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
                        // 残薬計算ボタン
                        Button(action: {
                            // 入力された処方日数はString型のためキャスト。後にif let文でnilチェックするためInt?型にする
                            let prescriptionDays: Int? = Int(self.prescriptionDays)
                            // 内服開始日と内服中断日の差を計算
                            // 内服開始日を計算に含むためincludestartDateはtrueとする
                            let dateSpan: Int = DateCalculator().calclateSpan(startDate: self.startDate, endDate: self.interruptionDate, includestartDate: true)
                            
                            // 日数の差がマイナスになる場合はアラートを表示するして処理を抜ける
                            if dateSpan < 0 {
                                alertType = .incorrectSelectedDate
                                showAlert = true
                                return
                            }
                            
                            // 処方日数のnilチェック。0は入力されうるためチェックしない
                            if let prescriptionDays = prescriptionDays {
                                // 残薬数の計算
                                numberOfDaysLeftoverMedicines = prescriptionDays - dateSpan
                                
                                // 残薬数がマイナスになる場合は内服できていなかったかもしれない旨のアラートを表示する
                                if numberOfDaysLeftoverMedicines < 0 {
                                    alertType = .runOutMedicine
                                    showAlert = true
                                }
                            } else {
                                // 処方日数に値が入力されていない場合はアラートを表示する
                                alertType = .incorrectInputValue
                                showAlert = true
                            }
                        }) {
                            Text("計算")
                        } //Button
                        .buttonStyle(PrimaryButtonStyle())
                    } // HStack
                } // Section
                
                // 計算結果表示部分
                Section {
                    VStack {
                        Text("\(startDate, formatter: dateFormat)から")
                        Text("\(interruptionDate, formatter: dateFormat)まで")
                        Text("内服している場合")
                        (Text("残薬は")
                         + Text("\(numberOfDaysLeftoverMedicines)日分").foregroundColor(Color.red)
                         + Text("あると考えられます"))
                    } // VStack
                    // Sction内のVStackの要素がTextの幅と同値であったためmaxWidthをinfinityとし、その上でcenterで中央寄せにした
                    .frame(maxWidth:.infinity, alignment: .center)
                    .font(.title3)
                } // Section
            }// Form
            // 設定した背景色を有効にするためにFormのデフォルトの背景色を透明にした
            .onAppear() {
                UITableView.appearance().backgroundColor = .clear
            }
            // keyboard外をタップするとkeyboardを閉じる処理
            .onTapGesture {
                UIApplication.shared.closeKeyboard()
            }
            // Alert部分
            .alert(isPresented: $showAlert) {
                switch alertType {
                    // 入力値が誤っているケース
                case .incorrectInputValue:
                    return Alert(title: Text("正しい値を入力してください"), message: Text("処方日数には0以上の数字を\n入力してください"), dismissButton: .default(Text("OK")))
                    // 中断日が内服開始日より前の日付になっているケース
                case .incorrectSelectedDate:
                    return Alert(title: Text("正しい値を入力してください"), message: Text("中断日は内服開始日より\n後の日付を選択してください"), dismissButton: .default(Text("OK")))
                    // 残薬数がマイナスになるケース
                case .runOutMedicine:
                    return Alert(title: Text("処方日数が足りていません"), message: Text("何日間か内服できていなかった\n可能性があります"), dismissButton: .default(Text("OK")))
                } // switch
            } // alert
        } // ZStack
    } // body
}

struct LeftoverMedicineCount_Previews: PreviewProvider {
    static var previews: some View {
        LeftoverMedicineCount()
    }
}
