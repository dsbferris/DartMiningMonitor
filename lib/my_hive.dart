import 'package:hive/hive.dart';

import 'package:dart_mining_monitor/flexpool/api_models/workers_response.dart';

import 'flexpool/hive_models/chat_entry.dart';

const workerBoxName = "workerShares";
const chatsBoxName = "chats";

Future<Box<Worker>> _getWorkerBox() async{
  return await Hive.openBox<Worker>(workerBoxName);
}

Future<Box<ChatEntry>> _getChatBox() async {
  return await Hive.openBox<ChatEntry>(chatsBoxName);
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

Future<bool> addChat(ChatEntry c) async{
  var box = await _getChatBox();
  bool exists = box.containsKey(c.chatId);
  if(!exists) await box.put(c.chatId, c);
  await box.close();
  //true if added, false if existing
  return !exists;
}
