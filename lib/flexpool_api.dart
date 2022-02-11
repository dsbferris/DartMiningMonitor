import 'dart:convert';

import 'package:flexpool_monitoring_telegram_bot/models/balance_response.dart';
import 'package:flexpool_monitoring_telegram_bot/models/payments_response.dart';
import 'package:http/http.dart' as http;

import 'models/daily_reward_per_gigahash_sec_response.dart';
import 'models/miner_stats_response.dart';
import 'models/payments_response.dart';
import 'models/workers_response.dart';

const String baseUrl = "api.flexpool.io";
const String minerAddress = "wallet";

Future<PaymentsResponse> getPayments({int page=0}) async {
  var url = Uri.https(baseUrl, "/v2/miner/payments", {
    "coin": "eth",
    "address": minerAddress,
    "countervalue": "eur",
    "page": page.toString()
  });
  var response = await http.get(url);
  if(response.statusCode == 200){
    return PaymentsResponse.fromJson(jsonDecode(response.body));
    // TODO Request more Pages if totalPages is > 1...
    // Dont forget to test this feature then...
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
    throw Exception("getDailyRewardPerGigahashSec() Response Error. Code != 200.");
  }
}

Future<MinerStatsResponse> getMinerStats() async{
  var url = Uri.https(baseUrl, "/v2/miner/stats", {
    "coin": "eth",
    "address": minerAddress
  });
  var response = await http.get(url);
  if(response.statusCode == 200){
    return MinerStatsResponse.fromJson(jsonDecode(response.body));
  }
  else{
    throw Exception("getMinerStats() Response Error. Code != 200.");
  }
}

Future<BalanceResponse> getBalance() async{
  var url = Uri.https(baseUrl, "/v2/miner/balance", {
    "coin": "eth",
    "address": minerAddress,
    "countervalue": "eur"
  });
  var response = await http.get(url);
  if(response.statusCode == 200){
    return BalanceResponse.fromJson(jsonDecode(response.body));
  }
  else{
    throw Exception("getBalance() Response Error. Code != 200.");
  }
}
