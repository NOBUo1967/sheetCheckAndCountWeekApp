//
//  SheetCount.swift
//  sheetCheckAndCountWeekApp
//
//  Created by Shinichiro Hirasawa on 2021/10/18.
//

// commit_message: 統一のButtonStyleにframeの要素を追加した

import SwiftUI

struct SheetCount: View {
    // 各入力値。TextFieldから値を受け取るためString型とする
    @State var dairyDose: String = ""
    @State var numberOfDay: String = ""
    @State var numberPerSheet: String = ""
    // 必要ヒート数。整数値しかありえないためInt型とする
    @State var total: Int = 0
    // あまり錠数。端数はあり得るためDouble型とする
    @State var fraction: Double = 0.0
    
    //　アラート表示のための状態変数
    @State var showAlert:Bool = false
    
    var body: some View {
        // 背景色を設定するためにZStackを設置
        ZStack {
            // 背景色の設定
            Color.customBeige
                .edgesIgnoringSafeArea(.all)
            Form {
                Section {
                    HStack {
                        Text("1日必要錠(包)数")
                        // 両端寄せにするためにスペースを挿入
                        Spacer()
                        TextField("錠(包)", text: self.$dairyDose)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.decimalPad)
                            .frame(width: 110, height: 30)
                    } // HStack
                    
                    HStack {
                        Text("処方日数")
                        // 両端寄せにするためにスペースを挿入
                        Spacer()
                        TextField("日", text: self.$numberOfDay)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.numberPad)
                            .frame(width: 110, height: 30)
                    } // HStack
                    
                    HStack {
                        Text("1シート(つづり)\nあたりの錠(包)数")
                        // 両端寄せにするためにスペースを挿入
                        Spacer()
                        TextField("錠(包)", text: self.$numberPerSheet)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.numberPad)
                            .frame(width: 110, height: 30)
                    } // HStack
                    
                    // 計算ボタン
                    HStack {
                        // Buttonを右端寄せにするためにSpacerを設置した
                        Spacer()
                        Button(action: {
                            // キャストしてOptional型にしておかないとif let文で、nilチェックできないため、ここで値をDouble型にキャストしておく
                            let dairyDoseDouble:Double? = Double(dairyDose)
                            let numberOfDayDouble:Double? = Double(numberOfDay)
                            let numberPerSheetDouble: Double? = Double(numberPerSheet)
                            // 各値のnilチェックと空文字チェック
                            // 「 8」などスペース始まりの文字は弾いていないが、キーボードをNamPadに指定しているため問題ないと考える。
                            if let dairyDose = dairyDoseDouble, let numberOfDay = numberOfDayDouble, let numberPerSheet = numberPerSheetDouble, numberPerSheet != 0 {
                                // 必要ヒート数を計算
                                self.total = Int(dairyDose * numberOfDay / numberPerSheet)
                                // 端数の錠数を計算。小数点第3位で四捨五入する
                                self.fraction = round((dairyDose * numberOfDay).truncatingRemainder(dividingBy: numberPerSheet)*100) / 100
                            } else {
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
                        // 端数は小数点第二位まで表示する。1回0.25錠までが現実的なところ。
                        (Text("\(self.total)").foregroundColor(Color.red)
                         + Text("シート(つづり)"))
                        (Text("+")
                         + Text("\(String(format: "%.2f", self.fraction))").foregroundColor(Color.red)
                         + Text("錠(包)"))
                        Text("必要です")
                    }// VStack
                    // Sction内のVStackの要素がTextの幅と同値であったためmaxWidthをinfinityとし、その上でcenterで中央寄せにした
                    .frame(maxWidth:.infinity, alignment: .center)
                    .font(.title2)
                } // Section
            } // Form
            // 設定した背景色を有効にするためにFormのデフォルトの背景色を透明にした
            .onAppear() {
                UITableView.appearance().backgroundColor = .clear
            }
            // keyboard外をタップするとkeyboardを閉じる処理
            .onTapGesture {
                UIApplication.shared.closeKeyboard()
            }
            //
            .alert(isPresented: $showAlert) {
                Alert(title: Text("正しい値を入力してください"), message: Text("入力できる値は数値のみです\n1シートあたりの錠数に\n０は入力できません"), dismissButton: .default(Text("OK")))
            }
        } // ZStack
    } // body
}



struct SheetCount_Previews: PreviewProvider {
    static var previews: some View {
        SheetCount()
    }
}
