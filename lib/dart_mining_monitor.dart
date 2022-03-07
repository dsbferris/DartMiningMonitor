import 'package:dart_mining_monitor/flexpool_telegram.dart';
import 'package:teledart/model.dart';
import 'package:teledart/teledart.dart';
import 'package:teledart/telegram.dart';

import 'flexpool_telegram.dart';
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

void testTelegram({required String token}) async{
  var teledart = await getTeleDart(token);
  var myBot = MyTeleDartBot(teledart: teledart); //this also handles all stuff.
  //myBot.testTelegram();
}

Future<TeleDart> getTeleDart(token) async {
  final me = await Telegram(token).getMe();
  final username = me.username;
  // TeleDart uses longpoll by default if no update fetcher is specified.
  return TeleDart(token, Event(username!));
}
