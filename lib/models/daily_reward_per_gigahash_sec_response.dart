// Big thanks to
// https://javiercbk.github.io/json_to_dart/
// for his nice tool!

import 'dart:math';

class DailyRewardPerGigahashSecResponse {
  String? error;
  num? result;

  DailyRewardPerGigahashSecResponse({this.error, this.result});

  DailyRewardPerGigahashSecResponse.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    result = json['result'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['error'] = error;
    data['result'] = result;
    return data;
  }

  num getDaysLeft(num payoutLimitWei, num currentBalanceWei, num hashrateInHashesPerSec){
    num weiLeftForPayout = payoutLimitWei - currentBalanceWei;
    num dailyGeneratedWei = (result! * hashrateInHashesPerSec) / pow(10, 9);
    num daysLeft = weiLeftForPayout / dailyGeneratedWei;
    return daysLeft;
  }
}
