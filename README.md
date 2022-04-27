# 日数と残薬計算
薬剤師業務の日中のちょっとした計算を楽にするために作成したアプリケーションです。<br>
<br>
# 機能
＜日数計算＞<br>
+ 開始日から終了日までの日数を計算します。<br>
+ 次回受診日までの処方日数の確認などにお使いください。<br>
<img src="https://user-images.githubusercontent.com/66336936/165643090-8cd2bc8b-50ae-4688-83b6-2edc61b030cb.png" width="320px">
<br>
<br>
＜何日後はいつ＞<br>
+ 開始日から何日後はいつかを計算します。<br>
+ 使用期限や休薬期間などの計算にご利用ください。<br>
<img src="https://user-images.githubusercontent.com/66336936/165643388-ca3fb7fb-d068-4afa-b79f-2d787cc0b676.png" width="320px">
<br>
<br>
＜ヒート数計算＞<br>
+ 1日の必要錠数(包数)、処方日数、1シートあたり錠数(1つづりあたりの包数)から必要なシート数と端数を計算します。<br>
+ 計数調剤の際にご利用ください。<br>
<img src="https://user-images.githubusercontent.com/66336936/165643614-eb88c694-b9a1-40af-ba82-c935598249bb.png" width="320px">
<br>
<br>
＜残薬計算＞<br>
+ 内服開始日、処方日数、中断日から残薬を計算します。<br>
+ 中断日には受診日や入院日などを入力してください。<br>
<img src="https://user-images.githubusercontent.com/66336936/165643750-7f7b930c-e59c-4150-ac34-095e298b35ce.png" width="320px">
+ 残薬がマイナスになる場合は内服できていなかった可能性を示唆するアラートが表示されます。<br>
<img src="https://user-images.githubusercontent.com/66336936/165644159-0779cd5e-70ec-4d68-9c7c-9a1c4f20a90a.png" width="320px">
<br>
<br>

# 使用言語、FW、ツール
+ Swift
+ SwiftUI
+ CocoaPods
+ Google Mobile Ads SDK
+ GitHub(プロダクト管理に利用)
<br>

## 作成した動機
日々の薬剤師業務の中で行うちょっと面倒な計算を少しでも楽にしたいと思い開発しました。<br>
例えば、退院の準備の際に次の受診の日までお薬が足りるように
