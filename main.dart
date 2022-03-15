import 'dart:io';

import 'package:dart_mining_monitor/dart_mining_monitor.dart'
    as dmm;
import 'package:dart_mining_monitor/flexpool/api_models/workers_response.dart';
import 'package:dart_mining_monitor/flexpool/hive_models/chat_entry.dart';
import 'package:hive/hive.dart';
import 'package:dart_mining_monitor/my_teledart_bot.dart';
import 'package:cron/cron.dart';
import 'package:dart_mining_monitor/flexpool/api.dart' as api;

void main(List<String> arguments) async {
/*
  final cron = Cron();
  print(DateTime.now());
  cron.schedule(Schedule.parse("* * * * *"), () async {
    print("Every minute");
    print(DateTime.now());
  });
  await Future.delayed(const Duration(minutes: 5, seconds: 10));
  print("Delay finished");
  print(DateTime.now());
  await cron.close(); //after this all cron-jobs will be stopped, so don't run it ;)
  print("cron close");
  await Future.delayed(const Duration(minutes: 5, seconds: 10));
  print("Delay finished");
  print(DateTime.now());

 */
/*
  var stream = Stream<int>.periodic(Duration(seconds: 3), (computationCount) {
    print(computationCount);
    return computationCount;
  });
  var listener = stream.listen((event) {
    //event is return value of stream. If you give type T for stream, e.g. <int>
    //event will be of type int
    //In this method you can handle stuff, that happens right after the stream returns data
    print(event);
  });
 */

  initHive();
  parseAndHandleArgs(arguments);
  var myBot = MyTeleDartBot(teledart: await MyTeleDartBot.getTeleDart(getTelegramApiToken()));
  myBot.loadCronJobsFromOldSessions();

}

String getTelegramApiToken(){
  var token = Platform.environment["BOT_TOKEN"];
  if(token == null) throw Exception("No token given");
  return token;
}

void initHive(){
  var path = Directory.current.path;
  path = path + Platform.pathSeparator + "my_hive_dir";
  Hive
    ..init(path)
    ..registerAdapter(WorkerAdapter())
    ..registerAdapter(ChatAdapter());
}

void parseAndHandleArgs(List<String> arguments){
  if(arguments.contains("-h") || arguments.contains("--help")){
    print("Here should be your help... but well, it isn't yet.");
  }
  if(arguments.contains("--delete-hive")){
    throw UnimplementedError("Delete Hive not implemented yet.");
  }
}
