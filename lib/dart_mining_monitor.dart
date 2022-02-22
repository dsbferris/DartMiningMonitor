import 'package:dart_mining_monitor/flexpool_telegram.dart';
import 'package:teledart/model.dart';
import 'package:teledart/teledart.dart';
import 'package:teledart/telegram.dart';

import 'flexpool_api.dart';
import 'flexpool_hive.dart' as db;

int calculate() {
  return 6 * 7;
}

Future<void> startMonitoring(String minerAddress) async {
  print("Starting monitoring...");
  var api = FlexpoolApi(minerAddress: minerAddress);
  var response = await api.getWorkers();
  if(response.result != null){
    for(var w in response.result!){
      db.storeWorker(w);
    }
    for(var w in response.result!){
      if(w.name != null) {
        var worker = await db.getWorker(w.name!);
        print(worker);
      }
    }
    db.printBox();
  }
}


void testTelegram({required String token, required int privateChatId, required int groupChatId }) async{
  print("Starting teledart");
  //TODO Do hands on check if this shit could work and how it works
  final username = (await Telegram(token).getMe()).username;

  // TeleDart uses longpoll by default if no update fetcher is specified.
  var teledart = TeleDart(token, Event(username!));

  teledart.start();

  // You can listen to messages like this
  teledart.onMessage(entityType: 'bot_command', keyword: 'start').listen(
  (message) => teledart.sendMessage(message.chat.id, 'Hello TeleDart!'));

  // Sick of boilerplates? Reply messages like below, nice and tidy
  // Short hands also available for answer query methods
  teledart.onCommand('short')
      .listen((message) => message.reply('This works too!'));

  // You can also utilise regular expressions
  teledart
      .onCommand(RegExp('hello', caseSensitive: false))
      .listen((message) => message.reply('hi!'));

  // You can even filter streams with stream processing methods
  // See: https://www.dartlang.org/tutorials/language/streams#methods-that-modify-a-stream
  teledart
      .onMessage(keyword: 'dart')
      .where((message) => message.text?.contains('telegram') ?? false)
      .listen((message) => message.replyPhoto(
  //  io.File('example/dash_paper_plane.png'),
  'https://raw.githubusercontent.com/DinoLeung/TeleDart/master/example/dash_paper_plane.png',
  caption: 'This is how Dash found the paper plane'));

  // Inline mode.
  teledart.onInlineQuery().listen((inlineQuery) => inlineQuery.answer([
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
