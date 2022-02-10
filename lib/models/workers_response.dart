// Big thanks to
// https://javiercbk.github.io/json_to_dart/
// for his nice tool!

class WorkersResponse {
  String? error;
  List<WorkersResponseResult>? result;

  WorkersResponse({this.error, this.result});

  WorkersResponse.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    if (json['result'] != null) {
      result = <WorkersResponseResult>[];
      json['result'].forEach((v) {
        result!.add(WorkersResponseResult.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['error'] = error;
    if (result != null) {
      data['result'] = result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WorkersResponseResult{
  String? name;
  bool? isOnline;
  num? count;
  num? reportedHashrate;
  num? currentEffectiveHashrate;
  num? averageEffectiveHashrate;
  num? validShares;
  num? staleShares;
  num? invalidShares;
  num? lastSeen;

  WorkersResponseResult(
      {this.name,
        this.isOnline,
        this.count,
        this.reportedHashrate,
        this.currentEffectiveHashrate,
        this.averageEffectiveHashrate,
        this.validShares,
        this.staleShares,
        this.invalidShares,
        this.lastSeen});

  WorkersResponseResult.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    isOnline = json['isOnline'];
    count = json['count'];
    reportedHashrate = json['reportedHashrate'];
    currentEffectiveHashrate = json['currentEffectiveHashrate'];
    averageEffectiveHashrate = json['averageEffectiveHashrate'];
    validShares = json['validShares'];
    staleShares = json['staleShares'];
    invalidShares = json['invalidShares'];
    lastSeen = json['lastSeen'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['isOnline'] = isOnline;
    data['count'] = count;
    data['reportedHashrate'] = reportedHashrate;
    data['currentEffectiveHashrate'] = currentEffectiveHashrate;
    data['averageEffectiveHashrate'] = averageEffectiveHashrate;
    data['validShares'] = validShares;
    data['staleShares'] = staleShares;
    data['invalidShares'] = invalidShares;
    data['lastSeen'] = lastSeen;
    return data;
  }

}
