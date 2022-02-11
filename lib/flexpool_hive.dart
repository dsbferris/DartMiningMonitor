import 'package:hive/hive.dart';

import 'models/workers_response.dart';

const workerBoxName = "workerShares";


Future<Box<Worker>> _getWorkerBox() async{
  return await Hive.openBox<Worker>(workerBoxName);
}

void storeWorker(Worker w) async{
  if(w.name == null) throw ArgumentError.value(w.name, "w.name");
  var box = await _getWorkerBox();
  if(box.containsKey(w.name)){
    //TODO ADD WORKER
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
