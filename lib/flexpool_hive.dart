import 'package:hive/hive.dart';

import 'package:dart_mining_monitor/flexpool/api_models/workers_response.dart';

import 'flexpool/hive_models/wallet_time_nickname.dart';

const workerBoxName = "workerShares";
const chatsBox = "chats";

Future<Box<Worker>> _getWorkerBox() async{
  return await Hive.openBox<Worker>(workerBoxName);
}

void storeWorker(Worker w) async{
  if(w.name == null) throw ArgumentError.value(w.name, "w.name");
  var box = await _getWorkerBox();
  if(box.containsKey(w.name)){
    //TODO ADD WORKER SHARES
  }
  else{
    await box.put(w.name, w);
  }
}

Future<Worker?> getWorker(String name) async{
  var box = await _getWorkerBox();
  return box.get(name);
}

void printBox() async{
  var box = await _getWorkerBox();
  for(var w in box.values){
    print(w);
  }
}

Future<bool> addWalletToChatBox(String chatId, String wallet, DateTime time, String nickname) async{
  var wtn = WalletTimeNickname(wallet: wallet, time: time, nickname: nickname, chatId: chatId);
  var box = await Hive.openBox<List<WalletTimeNickname>>(chatsBox);
  List<WalletTimeNickname>? existingList = box.get(chatId)?.cast<WalletTimeNickname>();

  List<WalletTimeNickname> newList = [];
  if(existingList != null) {
    for(final i in existingList){
      if(i.wallet == wallet) return false;
    }
    newList = existingList..add(wtn);
  } else {
    newList.add(wtn);
  }
  box.put(chatId, newList);
  return true;
}
