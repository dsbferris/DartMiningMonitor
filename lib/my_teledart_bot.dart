import 'package:dart_mining_monitor/flexpool/api.dart';
import 'package:dart_mining_monitor/flexpool/hive_models/wallet_time_nickname.dart';
import 'package:dart_mining_monitor/flexpool/random_names.dart';
import 'package:dart_mining_monitor/flexpool_hive.dart';
import 'package:hive/hive.dart';
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

    //teledart.onCommand(RegExp("help", caseSensitive: false)).listen(helpCommand);



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
    if(message.chat.type == "private"){
      teledart.sendMessage(message.chat.id,
          'Hello ${message.chat.username}!\n'
          'Please send me your address.\n'
          'Use the following format:\n'
          '/wallet 0xYOURWALLET123');
    }
    else if(message.chat.type == "group"){
      teledart.sendMessage(message.chat.id,
          'Hello ${message.chat.title}!\n'
          'Please send me your address.\n'
          'Use the following format:\n'
          '/wallet 0xYOURWALLET123');
    }

  }

  Future<void> walletCommand(TeleDartMessage message) async {
    var text = message.text ?? "";
    var wallet = extractWalletFromString(text);
    if(wallet == null) {
      message.reply("Use the following format:\n"
          "/wallet address (time nickname)\n"
          "Arguments in curly braces are optional.\n"
          "Examples:\n"
          "/wallet 0x1234 ");
    }
    else{
      var locateWallet = await Api(minerAddress: wallet).getLocateWallet();
      if(locateWallet == null || locateWallet != "eth"){
        message.reply('The given wallet $wallet is not known at flexpool.\n'
            'Sure you entered the right one?\n'
            'Please retry using /wallet 0xYOURWALLET123'
        );
      }
      else{
        final time = DateTime.now();
        // delay daily report time by three minutes,
        // so that the api calls have at least one minute to finish
        // added one minute on top, not to have problem at XX:XX:59
        final requestTime = time.add(const Duration(minutes: 2));
        final notifyTime = time.add(const Duration(minutes: 3));
        final nickname = getRandomName();
        //TODO Setup cron job!
        var success = await addWalletToChatBox(message.chat.id.toString(), wallet, time, nickname);
        if(success){
          message.reply("Successfully added your wallet:\n"
              "$wallet\n"
              "Let's name it:\n"
              "$nickname\n"
              "You will be notified every day at:\n"
              "${notifyTime.hour}:${notifyTime.minute}\n"
              );
          helpCommand(message);
        }
        else{
          message.reply("Your wallet is already registered!");
        }
      }
    }
  }

  void changeTimeCommand(TeleDartMessage message){
    //TODO Implement change time command
    // /changeTime 16:45
    print("TODO IMPLEMENT");
  }

  void changeNicknameCommand(TeleDartMessage message){
    //TODO Implement change nickname command
    // /changeNickname NICKNAME
    print("TODO IMPLEMENT");
  }

  void deleteCommand(TeleDartMessage message){
    //TODO Implement delete command
    // /delete
    print("TODO IMPLEMENT");
  }

  void helpCommand(TeleDartMessage message){
    message.reply(
        "To change that name use the command\n"
        "/changeNickname NICKNAME\n"
        "To change the time use the command\n"
        "/changeTime 16:45\n"
        "Note! Changing the notify time does not change the time flexpool api gets requested.\n"
        "If you wan't me to delete all your data, use:\n"
        "/delete I REALLY WANT THIS");
  }



  void loadCronJobsFromOldSessions() async{
    //TODO Implement load old cron jobs
    print("Implement that shit bro...");
  }

  String? extractWalletFromString(String text){
    for(final t in text.split(" ")){
      if(t.toLowerCase().contains("0x".toLowerCase())){
        if(t.length != 42) {
          return null;
        } else {
          return t;
        }
      }
    }
    return null;
  }



}
