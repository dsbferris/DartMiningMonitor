import 'package:flexpool_monitoring_telegram_bot/flexpool_monitoring_telegram_bot.dart'
    as flexpool_monitoring_telegram_bot;

void main(List<String> arguments) {
  print('Hello world: ${flexpool_monitoring_telegram_bot.calculate()}!');
  flexpool_monitoring_telegram_bot.startMonitoring();
}
