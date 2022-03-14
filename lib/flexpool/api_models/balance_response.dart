// Big thanks to
// https://javiercbk.github.io/json_to_dart/
// for his nice tool!

class BalanceResponse {
  String? error;
  BalanceResponseResult? result;

  BalanceResponse({this.error, this.result});

  BalanceResponse.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    result =
    json['result'] != null ? BalanceResponseResult.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['error'] = error;
    if (result != null) {
      data['result'] = result!.toJson();
    }
    return data;
  }
}

class BalanceResponseResult {
  num? balance;
  num? balanceCountervalue;
  num? price;

  BalanceResponseResult({this.balance, this.balanceCountervalue, this.price});

  BalanceResponseResult.fromJson(Map<String, dynamic> json) {
    balance = json['balance'];
    balanceCountervalue = json['balanceCountervalue'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['balance'] = balance;
    data['balanceCountervalue'] = balanceCountervalue;
    data['price'] = price;
    return data;
  }
}
