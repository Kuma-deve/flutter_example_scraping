import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;
import 'package:translator/translator.dart';

void main(){
  getTranslate();
}

void getTranslate(){
  //https://pub.dev/packages/translator
  //こちらのパッケージはAPIなしでも使用可能
  final translator = GoogleTranslator();
  final input = "こんにちは";

  translator.translate(input, from: 'ja',to: 'en').then(print);
}

void getQiita()async{
  //参考になるサイト
  //https://zenn.dev/tris/articles/9705b93a02425f
  //https://zenn.dev/7oh/articles/fe9fa855859011
  //外のサイトのスクレイピングをしたい場合

  //URLの指定
  final url = "https://qiita.com/";
  final target = Uri.parse(url);
  //サイトを読み込む
  final response = await http.get(target) ;

  //もしエラーのステータスコードが帰ってきたときはエラーをコンソルに表示する
  if(response.statusCode != 200){
    print('ERROR: ${response.statusCode}');
    //エラーの場合は処理をここで終了
    return;
  }
  //response.bodyにはサイトのhtmlコードなどが入っている状態
  final document = parse(response.body);
  //classやidなどを指定してあげる
  //例)id → #name class → .name その他)h1 spanなど
  final result = document.querySelectorAll(".css-1fhgjcy < a").map((e) => e.text).toList();
  //指定したclassなどの中にあった値を表示
  print(result);
}
