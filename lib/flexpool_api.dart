import 'dart:convert';

import 'package:flexpool_monitoring_telegram_bot/models/payments_response.dart';
import 'package:http/http.dart' as http;

import 'models/daily_reward_per_gigahash_sec_response.dart';
import 'models/payments_response.dart';
import 'models/workers_response.dart';

const String baseUrl = "api.flexpool.io";
const String minerAddress = "wallet";

Future<PaymentsResponse> getPayments() async {
  var url = Uri.https(baseUrl, "/v2/miner/payments", {
    "coin": "eth",
    "address": minerAddress,
    "countervalue": "eur",
    "page": "0"
  });
  var response = await http.get(url);
  if(response.statusCode == 200){
    return PaymentsResponse.fromJson(jsonDecode(response.body));
    // TODO Request more Pages if totalPages is > 1...
  }
  else{
    throw Exception("getPayments() Response Error. Code != 200.");
  }
}

Future<WorkersResponse> getWorkers() async{
  var url = Uri.https(baseUrl, "/v2/miner/workers", {
    "coin": "eth",
    "address": minerAddress
  });
  var response = await http.get(url);
  if(response.statusCode == 200){
    return WorkersResponse.fromJson(jsonDecode(response.body));
  }
  else{
    throw Exception("getWorkers() Response Error. Code != 200.");
  }
}

Future<DailyRewardPerGigahashSecResponse> getDailyRewardPerGigahashSec() async{
  var url = Uri.https(baseUrl, "/v2/pool/dailyRewardPerGigahashSec", {
    "coin": "eth"
  });
  var response = await http.get(url);
  if(response.statusCode == 200){
    return DailyRewardPerGigahashSecResponse.fromJson(jsonDecode(response.body));
  }
  else{
    throw Exception("getWorkers() Response Error. Code != 200.");
  }
}
