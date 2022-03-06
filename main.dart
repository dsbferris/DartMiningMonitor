import 'dart:io';

import 'package:dart_mining_monitor/dart_mining_monitor.dart'
    as dmm;
import 'package:dart_mining_monitor/models/workers_response.dart';
import 'package:hive/hive.dart';

String getTelegramApiToken(){
  var token = Platform.environment["BOT_TOKEN"];
  if(token == null) throw Exception("No token given");
  return token;
}

void initHive(){
  Hive.init("my_hive_dir");
  Hive.registerAdapter(WorkerAdapter());
}

void parseAndHandleArgs(List<String> arguments){

  if(arguments.contains("-h") || arguments.contains("--help")){
    print("Here should be your help... but well, it isn't yet.");
  }

  if(arguments.contains("--delete-hive")){
    throw UnimplementedError("Delete Hive not implemented yet.");
  }
}

void main(List<String> arguments) {

  var token = getTelegramApiToken();
  initHive();
  parseAndHandleArgs(arguments);

  dmm.testTelegram(token: token);



  print('Hello world: ${dmm.calculate()}!');

  //This does not disturb the telegram bot.
  /*
  var stream = Stream.periodic(const Duration(seconds: 10), (computationCount) async => {
    await dmm.startMonitoring(minerAddress)
  });
  stream.listen((event) {
    print("Stream responded");
  });

   */
}
