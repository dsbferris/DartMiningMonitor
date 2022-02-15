import 'flexpool_api.dart' as api;
import 'flexpool_hive.dart' as db;

int calculate() {
  return 6 * 7;
}

Future<void> startMonitoring() async {
  print("Starting monitoring...");
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
