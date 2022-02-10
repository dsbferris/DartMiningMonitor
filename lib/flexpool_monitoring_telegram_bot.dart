import 'flexpool_api.dart' as api;

int calculate() {
  return 6 * 7;
}

Future<void> startMonitoring() async {
  print("Starting monitoring...");
  var p = await api.getPayments();
  var w = await api.getWorkers();
  var d = await api.getDailyRewardPerGigahashSec();
  var payouts = p.result?.data ?? [];
  print(payouts);
  print(p);
  print(w);
  print(d);
}
