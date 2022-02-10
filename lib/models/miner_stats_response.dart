class MinerStatsResponse {
  String? error;
  MinerStatsResponseResult? result;

  MinerStatsResponse({this.error, this.result});

  MinerStatsResponse.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    result =
    json['result'] != null ? MinerStatsResponseResult.fromJson(json['result']) : null;
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

class MinerStatsResponseResult {
  num? currentEffectiveHashrate;
  num? averageEffectiveHashrate;
  num? reportedHashrate;
  num? validShares;
  num? staleShares;
  num? invalidShares;

  MinerStatsResponseResult(
      {this.currentEffectiveHashrate,
        this.averageEffectiveHashrate,
        this.reportedHashrate,
        this.validShares,
        this.staleShares,
        this.invalidShares});

  MinerStatsResponseResult.fromJson(Map<String, dynamic> json) {
    currentEffectiveHashrate = json['currentEffectiveHashrate'];
    averageEffectiveHashrate = json['averageEffectiveHashrate'];
    reportedHashrate = json['reportedHashrate'];
    validShares = json['validShares'];
    staleShares = json['staleShares'];
    invalidShares = json['invalidShares'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['currentEffectiveHashrate'] = currentEffectiveHashrate;
    data['averageEffectiveHashrate'] = averageEffectiveHashrate;
    data['reportedHashrate'] = reportedHashrate;
    data['validShares'] = validShares;
    data['staleShares'] = staleShares;
    data['invalidShares'] = invalidShares;
    return data;
  }
}
