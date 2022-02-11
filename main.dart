import 'package:flexpool_monitoring_telegram_bot/flexpool_monitoring_telegram_bot.dart'
    as flexpool_monitoring_telegram_bot;
import 'package:flexpool_monitoring_telegram_bot/models/workers_response.dart';
import 'package:hive/hive.dart';

void main(List<String> arguments) {
  if(arguments.contains("-h") || arguments.contains("--help")){
    print("Here should be your help... but well, it isn't yet.");
  }
  
  Hive.init("my.hive");
  Hive.registerAdapter(WorkerAdapter());
  if(arguments.contains("--delete-hive")){
    
  }
  print('Hello world: ${flexpool_monitoring_telegram_bot.calculate()}!');
  flexpool_monitoring_telegram_bot.startMonitoring();
}
