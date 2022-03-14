import 'package:dart_mining_monitor/my_teledart_bot.dart';
import 'package:teledart/teledart.dart';
import 'package:teledart/telegram.dart';

import 'my_teledart_bot.dart';
import 'flexpool/api.dart';
import 'flexpool_hive.dart' as db;

int calculate() {
  return 6 * 7;
}

Future<void> startMonitoring(String minerAddress) async {
  print("Starting monitoring...");
  var api = Api(minerAddress: minerAddress);
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


void testTelegram({required String token}) async {
  var teledart = await MyTeleDartBot.getTeleDart(token);
  var myBot = MyTeleDartBot(teledart: teledart); //this also handles all stuff.
  //myBot.testTelegram();
}


