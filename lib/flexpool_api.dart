import 'dart:convert';

import 'package:flexpool_monitoring_telegram_bot/models/payout_response.dart';
import 'package:http/http.dart' as http;

import 'models/payout_response.dart';

const String baseUrl = "api.flexpool.io";
const String minerAddress = "wallet";

Future<PayoutResponse> getPayout() async {
  // TODO SUPPORT MORE PAGES!
  var url = Uri.https(baseUrl, "/v2/miner/payments", {
    "coin": "eth",
    "address": minerAddress,
    "countervalue": "eur",
    "page": "0"
  });
  var response = await http.get(url);
  return PayoutResponse.fromJson(jsonDecode(response.body));
}
