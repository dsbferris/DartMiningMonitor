import 'dart:io';

import 'package:flexpool_monitoring_telegram_bot/dart_mining_monitor.dart'
    as flexpool_monitoring_telegram_bot;
import 'package:flexpool_monitoring_telegram_bot/models/workers_response.dart';
import 'package:hive/hive.dart';

void main(List<String> arguments) {

  var minerAddress = Platform.environment["MINER_ADDRESS"];
  var token = Platform.environment["BOT_TOKEN"];
  var ferrisChatId = Platform.environment["FERRIS_CHAT_ID"];
  var groupChatId = Platform.environment["GROUP_CHAT_ID"];

  if(arguments.contains("-h") || arguments.contains("--help")){
    print("Here should be your help... but well, it isn't yet.");
  }
  
  Hive.init("my.hive");
  Hive.registerAdapter(WorkerAdapter());
  //TODO Think about whether to use arguments or environment variables
  if(arguments.contains("--delete-hive")){
    throw UnimplementedError("Delete Hive not implemented yet.");
  }
  print('Hello world: ${flexpool_monitoring_telegram_bot.calculate()}!');
  flexpool_monitoring_telegram_bot.startMonitoring();
}
