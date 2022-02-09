import 'flexpool_api.dart' as api;

int calculate() {
  return 6 * 7;
}

Future<void> startMonitoring() async {
  print("Starting monitoring...");
  var p = await api.getPayout();
  print(p);
}
