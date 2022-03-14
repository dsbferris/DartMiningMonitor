import 'package:teledart/model.dart';
import 'package:teledart/teledart.dart';
import 'package:teledart/telegram.dart';
import 'package:teledart/model.dart' as tm;
class MyTeleDartBot{
  /// Return teledart instance with given [token]
  ///
  /// This method is needed to pass it to [MyTeleDartBot], because constructors
  /// can't work with async-await and I don't want to have a nullable instance
  /// of TeleDart in that class.
  static Future<TeleDart> getTeleDart(String token) async {
    final me = await Telegram(token).getMe();
    final username = me.username;
    // TeleDart uses longpoll by default if no update fetcher is specified.
    return TeleDart(token, Event(username!));
  }

  final TeleDart teledart;
  MyTeleDartBot({required this.teledart}){
    teledart.start();

    registerAllCommands();
    registerInlineQueries();

    print("Initialized teledart");
  }

  void registerAllCommands(){
    /*
    teledart.onMessage(entityType: 'bot_command', keyword: 'start')
        .listen(startCommand);
     */

    teledart.onCommand('start').listen(startCommand);

    teledart.onCommand("wallet").listen(walletCommand);

    //teledart.onCommand('short').listen(shortCommand);


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

  }

  void registerInlineQueries(){

    
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
  }


  void startCommand(TeleDartMessage message) {
    teledart.sendMessage(message.chat.id,
        'Hello ${message.from?.first_name}!\n'
        'Please send me your wallet address now (0x...)\n'
        'Use the following format: /wallet 0x...');
  }

  void walletCommand(TeleDartMessage message){
    var text = message.text ?? "";
    if(text.toLowerCase().contains("0x")){
      String wallet = "";
      for(final t in text.split(" ")){
        if(t.toLowerCase().contains("0x")) wallet = t;
      }
      //API Locate wallet, should return eth
      //if not, wallet is entered wrong or not known to flexpool

    }
    else{
      message.reply("Use the following format: /wallet 0x...");
    }
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
