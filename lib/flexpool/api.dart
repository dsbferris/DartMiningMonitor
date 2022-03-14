import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:dart_mining_monitor/flexpool/api_models/balance_response.dart';
import 'package:dart_mining_monitor/flexpool/api_models/miner_details_response.dart';
import 'package:dart_mining_monitor/flexpool/api_models/payments_response.dart';
import 'package:dart_mining_monitor/flexpool/api_models/daily_reward_per_gigahash_sec_response.dart';
import 'package:dart_mining_monitor/flexpool/api_models/miner_stats_response.dart';
import 'package:dart_mining_monitor/flexpool/api_models/workers_response.dart';

class Api {
  Api({required this.minerAddress});

  final String minerAddress;
  static const String _baseUrl = "api.flexpool.io";


  static const String _paymentsPath = "/v2/miner/payments";
  Future<PaymentsResponse> getPayments({int page=0}) async {
    var url = Uri.https(_baseUrl, _paymentsPath, {
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
      print(response.statusCode);
      throw Exception("getPayments() Response Error. Code != 200.");
    }
  }

  static const String _workersPath = "/v2/miner/workers";
  Future<WorkersResponse> getWorkers() async{
    var url = Uri.https(_baseUrl, _workersPath, {
      "coin": "eth",
      "address": minerAddress
    });
    var response = await http.get(url);
    if(response.statusCode == 200){
      return WorkersResponse.fromJson(jsonDecode(response.body));
    }
    else{
      print(response.statusCode);
      throw Exception("getWorkers() Response Error. Code != 200.");
    }
  }

  static const String _dailyRewardPerGigahashSecPath = "/v2/pool/dailyRewardPerGigahashSec";
  Future<DailyRewardPerGigahashSecResponse> getDailyRewardPerGigahashSec() async{
    var url = Uri.https(_baseUrl, _dailyRewardPerGigahashSecPath, {
      "coin": "eth"
    });
    var response = await http.get(url);
    if(response.statusCode == 200){
      return DailyRewardPerGigahashSecResponse.fromJson(jsonDecode(response.body));
    }
    else{
      print(response.statusCode);
      throw Exception("getDailyRewardPerGigahashSec() Response Error. Code != 200.");
    }
  }

  static const String _minerStatsPath = "/v2/miner/stats";
  Future<MinerStatsResponse> getMinerStats() async{
    var url = Uri.https(_baseUrl, _minerStatsPath, {
      "coin": "eth",
      "address": minerAddress
    });
    var response = await http.get(url);
    if(response.statusCode == 200){
      return MinerStatsResponse.fromJson(jsonDecode(response.body));
    }
    else{
      print(response.statusCode);
      throw Exception("getMinerStats() Response Error. Code != 200.");
    }
  }

  static const String _balancePath = "/v2/miner/balance";
  Future<BalanceResponse> getBalance() async{
    var url = Uri.https(_baseUrl, _balancePath, {
      "coin": "eth",
      "address": minerAddress,
      "countervalue": "eur"
    });
    var response = await http.get(url);
    if(response.statusCode == 200){
      return BalanceResponse.fromJson(jsonDecode(response.body));
    }
    else{
      print(response.statusCode);
      throw Exception("getBalance() Response Error. Code != 200.");
    }
  }

  static const String _detailsPath = "/v2/miner/details";
  Future<MinerDetailsResponse> getDetails() async {
    var url = Uri.https(_baseUrl, _detailsPath, {
      "coin": "eth",
      "address" : minerAddress,
    });
    var response = await http.get(url);
    if(response.statusCode == 200){
      return MinerDetailsResponse.fromJson(jsonDecode(response.body));
    }
    else{
      print(response.statusCode);
      throw Exception("getDetails() Response Error. Code != 200.");
    }
  }

}
