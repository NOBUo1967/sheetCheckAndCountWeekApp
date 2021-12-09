//
//  SheetCount.swift
//  sheetCheckAndCountWeekApp
//
//  Created by Shinichiro Hirasawa on 2021/10/18.
//

import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder),to: nil, from: nil,for: nil)
    }
}

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
        VStack {
            HStack {
                Text("1日必要錠(包)数")
                // 両端寄せにするためにスペースを挿入
                Spacer()
                TextField("錠(包)", text: self.$dairyDose)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.decimalPad)
                    .frame(width: 120, height: 30, alignment: .trailing)
                // TextField
            } // HStack 1日必要錠(包)数
            .padding()
            
            HStack {
                Text("処方日数")
                // 両端寄せにするためにスペースを挿入
                Spacer()
                TextField("日", text: self.$numberOfDay)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.numberPad)
                    .frame(width: 120, height: 30, alignment: .trailing)
                // TextField
            } // HStack 処方日数
            .padding()
            
            HStack {
                Text("1シート(つづり)あたりの\n錠(包)数")
                // 両端寄せにするためにスペースを挿入
                Spacer()
                TextField("錠(包)", text: self.$numberPerSheet)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.numberPad)
                    .frame(width: 120, height: 30, alignment: .trailing)
                // TextField
            } // HStack シートあたりの錠数
            .padding()

            
            Button(action: {
                // キャストしてOptional型にしておかないとif let文で、nilチェックできないため、ここで値をDouble型にキャストしておく
                let dairyDoseDouble:Double? = Double(dairyDose)
                let numberOfDayDouble:Double? = Double(numberOfDay)
                let numberPerSheetDouble: Double? = Double(numberPerSheet)
                // 各値のnilチェックと空文字チェック
                if let dairyDose = dairyDoseDouble, let numberOfDay = numberOfDayDouble, let numberPerSheet = numberPerSheetDouble, numberPerSheet != 0 {
                    self.total = Int(dairyDose * numberOfDay / numberPerSheet)
                    self.fraction = (dairyDose * numberOfDay).truncatingRemainder(dividingBy: numberPerSheet)
                } else {
                    showAlert = true
                }
                
                UIApplication.shared.endEditing()
            }) {
                Text("計算")
                    // buttonのデザインの部分
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                    .frame(width: 200, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .padding()
                    .background(Color.red)
                    .cornerRadius(10)
            } //Button
            // Buttonの要素自体のサイズ感を余白込みで指定する
            .frame(width: 300, height: 130, alignment: .center)
            
            // 端数は小数点第二位まで表示する。1回0.25錠までが現実的なところ。
            Text("\(self.total)シート(つづり)\n+\(String(format: "%.2f", self.fraction))錠(包)\n必要です")
        } // VStack
        .alert(isPresented: $showAlert) {
            Alert(title: Text("正しい値を入力してください"), message: Text("入力できる値は数値のみです\n1シートあたりの錠数に０は入力できません"), dismissButton: .default(Text("OK")))
        }
    }
}



struct SheetCount_Previews: PreviewProvider {
    static var previews: some View {
        SheetCount()
    }
}
