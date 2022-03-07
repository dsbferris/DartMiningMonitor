import 'package:teledart/model.dart';
import 'package:teledart/teledart.dart';
class MyTeleDartBot{

  final TeleDart teledart;

  MyTeleDartBot({required this.teledart}){
    teledart.start();
    // You can listen to messages like this
    teledart.onMessage(entityType: 'bot_command', keyword: 'start').listen(
        startCommand);

    // Sick of boilerplates? Reply messages like below, nice and tidy
    // Short hands also available for answer query methods
    teledart.onCommand('short').listen(
        shortCommand);

    // You can also utilise regular expressions
    teledart.onCommand(RegExp('hello', caseSensitive: false))
        .listen((message) => message.reply('hi!'));

    teledart.onCommand(RegExp("help", caseSensitive: false)).listen(helpCommand);

    

    // You can even filter streams with stream processing methods
    // See: https://www.dartlang.org/tutorials/language/streams#methods-that-modify-a-stream
    teledart.onMessage(keyword: 'dart')
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

  void startCommand(TeleDartMessage message){
    teledart.sendMessage(message.chat.id, 'Hello ${message.from?.first_name}!');
  }

  void shortCommand(TeleDartMessage message){
    message.reply('This works too!');
  }

  void helpCommand(TeleDartMessage message){
    List<List<InlineKeyboardButton>> keyboard = [];
    keyboard.add([InlineKeyboardButton(text: "test1", callback_data: "test1"), InlineKeyboardButton(text: "test2", callback_data: "test2")]);
    //keyboard.add([InlineKeyboardButton(text: "test3"), InlineKeyboardButton(text: "test4")]);
    //keyboard.add([InlineKeyboardButton(text: "LUL INLINE")]);
    var markup = InlineKeyboardMarkup(inline_keyboard: keyboard);
    message.reply("Call an ambulance, but not for me!", reply_markup: markup);
  }


}
