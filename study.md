- List.generate
https://api.flutter.dev/flutter/dart-core/List/List.generate.html

List<T>.generate(
  3, // listの要素数
  (index) => {} // 各要素に対する処理
)

- spread oprator ...
あるlistsの全ての値を他のlistsに突っ込む時に使う

var lists2 = [0, ...lists]

- UiqueKey
Creates a key that is equal only to itself.
The key cannot be created with a const constructor because that implies that all instantiated keys would be the same instance and therefore not be unique.

- 親Widgetから子Widgetへのpropの受け渡し

class Parent(
  Child(a: "", b: 1)
)

class Child(
  Child({
    required String a,
    required Int b
  })
)

- super(key: key)について
親Widgetの初期化に使っている？
https://stackoverflow.com/questions/52056035/myhomepagekey-key-this-title-superkey-key-in-flutter-what-would-b/52056959#52056959https://stackoverflow.com/questions/52056035/myhomepagekey-key-this-title-superkey-key-in-flutter-what-would-b/52056959#52056959

- nextDouble()
0.0から1.0までのrandomな値を生成する
https://api.flutter.dev/flutter/dart-math/Random/nextDouble.html

- Stack Widget
https://api.flutter.dev/flutter/widgets/Stack-class.html
childrenを重ね合わせる、ここでは雨粒を重ね合わせてる

- animationController.vsync
tickerProviderを設定するparameter.tickerは受信機の意味でtickerProviderはanimationの制御に関するあれこれを提供するクラスだと理解した.rainScreenでthisが使えるのはSingleTickerPrividerStateMixinを継承してるから

- animationの勉強になりそうな記事
https://blog.codemagic.io/flutter-custom-painter/
https://api.flutter.dev/flutter/widgets/AnimatedBuilder-class.html

- CustomPaint
画面に何かを描画するためのクラス

- ClassName._()という記述
privateなコンストラクタを作る（シングルトンクラスで使われるイメージかな
シングルトン=インスタンスを一つしか持たないクラス

- 変数生成時の修飾キーワード
  定数ならfinal or const
  変数ならtype or var

  - var（type）
  final, const及び型を指定しないことを意味する（型を書けば書かなくても可
  再代入可能
  https://qiita.com/uehaj/items/7c07f019e05a743d1022
  - final, const
  再代入不可
  constとfinalの違いは以下の記事に詳しい、現象の違いだけ説明するとfinalはlist等の要素なら変更可能、constはそれも無理（どんな型の変数も再代入不可
  https://qiita.com/uehaj/items/7c07f019e05a743d1022
  - late
  初期化後に生成される（遅延評価）non-nullable variable
  https://dart.dev/guides/language/language-tour#late-variables
  - static
  インスタンスを経由せずに呼び出せる変数
  https://dart.dev/guides/language/language-tour#class-variables-and-methods
  
- widget.propという記述
Widgetが受け取るpropsを使用する際の記述
余談だけど、状態（state）自体はState<T>クラスの中に記述した変数