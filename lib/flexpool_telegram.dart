import 'package:teledart/model.dart';
import 'package:teledart/teledart.dart';
import 'package:teledart/telegram.dart';

class MyTeleDartBot{
  MyTeleDartBot({required this.token});

  final String token;
  late final TeleDart _teledart;


  void init() async{
    print("Init teledart");
    final me = await Telegram(token).getMe();
    final username = me.username;
    // TeleDart uses longpoll by default if no update fetcher is specified.
    var teledart = TeleDart(token, Event(username!));
    teledart.start();
    print("Init teledart finished");
  }


  void testTelegram(){
    // You can listen to messages like this
    _teledart.onMessage(entityType: 'bot_command', keyword: 'start').listen(
            (message) => _teledart.sendMessage(message.chat.id, 'Hello TeleDart!'));

    // Sick of boilerplates? Reply messages like below, nice and tidy
    // Short hands also available for answer query methods
    _teledart.onCommand('short')
        .listen((message) => message.reply('This works too!'));

    // You can also utilise regular expressions
    _teledart
        .onCommand(RegExp('hello', caseSensitive: false))
        .listen((message) => message.reply('hi!'));

    // You can even filter streams with stream processing methods
    // See: https://www.dartlang.org/tutorials/language/streams#methods-that-modify-a-stream
    _teledart
        .onMessage(keyword: 'dart')
        .where((message) => message.text?.contains('telegram') ?? false)
        .listen((message) => message.replyPhoto(
      //  io.File('example/dash_paper_plane.png'),
        'https://raw.githubusercontent.com/DinoLeung/TeleDart/master/example/dash_paper_plane.png',
        caption: 'This is how Dash found the paper plane'));

    // Inline mode.
    _teledart.onInlineQuery().listen((inlineQuery) => inlineQuery.answer([
      InlineQueryResultArticle(
          id: 'ping',
          title: 'ping',
          input_message_content: InputTextMessageContent(
              message_text: '*pong*', parse_mode: 'MarkdownV2')),
      InlineQueryResultArticle(
          id: 'ding',
          title: 'ding',
          input_message_content: InputTextMessageContent(
              message_text: '*_dong_*', parse_mode: 'MarkdownV2')),
    ]));
    print("Finished teledart");
  }

  void sendMessage({required String text, required int chatId, required bool silent}) async{

  }
}
