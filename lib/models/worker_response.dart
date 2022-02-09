// Big thanks to
// https://javiercbk.github.io/json_to_dart/
// for his nice tool!

class WorkerResponse {
  String? error;
  List<WorkerResponseResult>? result;

  WorkerResponse({this.error, this.result});

  WorkerResponse.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    if (json['result'] != null) {
      result = <WorkerResponseResult>[];
      json['result'].forEach((v) {
        result!.add(new WorkerResponseResult.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    if (this.result != null) {
      data['result'] = this.result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WorkerResponseResult {
  String? name;
  bool? isOnline;
  int? count;
  int? reportedHashrate;
  int? currentEffectiveHashrate;
  double? averageEffectiveHashrate;
  int? validShares;
  int? staleShares;
  int? invalidShares;
  int? lastSeen;

  WorkerResponseResult(
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

  WorkerResponseResult.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['isOnline'] = this.isOnline;
    data['count'] = this.count;
    data['reportedHashrate'] = this.reportedHashrate;
    data['currentEffectiveHashrate'] = this.currentEffectiveHashrate;
    data['averageEffectiveHashrate'] = this.averageEffectiveHashrate;
    data['validShares'] = this.validShares;
    data['staleShares'] = this.staleShares;
    data['invalidShares'] = this.invalidShares;
    data['lastSeen'] = this.lastSeen;
    return data;
  }
}
