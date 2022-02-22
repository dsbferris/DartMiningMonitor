import 'dart:io';

import 'package:dart_mining_monitor/dart_mining_monitor.dart'
    as dmm;
import 'package:dart_mining_monitor/models/workers_response.dart';
import 'package:hive/hive.dart';

void main(List<String> arguments) {

  var minerAddress = Platform.environment["MINER_ADDRESS"];
  if(minerAddress == null) throw Exception("No minerAddress given");

  var token = Platform.environment["BOT_TOKEN"];
  if(token == null) throw Exception("No token given");

  var ferrisChatIdString = Platform.environment["FERRIS_CHAT_ID"];
  if(ferrisChatIdString == null) throw Exception("No privateChatId given");
  var ferrisChatId = int.parse(ferrisChatIdString);

  var groupChatIdString = Platform.environment["GROUP_CHAT_ID"];
  if(groupChatIdString == null) throw Exception("No groupChatId given");
  var groupChatId = int.parse(groupChatIdString);

  //Init teledart bot here. I will work smooth!
  dmm.testTelegram(token: token, privateChatId: ferrisChatId, groupChatId: groupChatId);



  if(arguments.contains("-h") || arguments.contains("--help")){
    print("Here should be your help... but well, it isn't yet.");
  }
  
  Hive.init("my_hive_dir");
  Hive.registerAdapter(WorkerAdapter());
  if(arguments.contains("--delete-hive")){
    throw UnimplementedError("Delete Hive not implemented yet.");
  }

  print('Hello world: ${dmm.calculate()}!');
  //dmm.startMonitoring(minerAddress);

  //This does not disturb the telegram bot.
  var stream = Stream.periodic(const Duration(seconds: 10), (computationCount) async => {
    await dmm.startMonitoring(minerAddress)
  });
  stream.listen((event) {
    print("Stream responded");
  });
}
