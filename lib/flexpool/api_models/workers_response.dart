// Big thanks to
// https://javiercbk.github.io/json_to_dart/
// for his nice tool!

import 'package:hive/hive.dart';

part 'workers_response.g.dart';

class WorkersResponse {
  String? error;
  List<Worker>? result;

  WorkersResponse({this.error, this.result});

  WorkersResponse.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    if (json['result'] != null) {
      result = <Worker>[];
      json['result'].forEach((v) {
        result!.add(Worker.fromJson(v));
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

@HiveType(typeId: 0)
class Worker extends HiveObject{
  @HiveField(0)
  String? name;
  @HiveField(1)
  num? validShares;
  @HiveField(2)
  num? staleShares;
  @HiveField(3)
  num? invalidShares;
  bool? isOnline;
  num? count;
  num? reportedHashrate;
  num? currentEffectiveHashrate;
  num? averageEffectiveHashrate;
  num? lastSeen;

  Worker(
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

  Worker.fromJson(Map<String, dynamic> json) {
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

  @override
  String toString() {
    return "$name: $validShares, $staleShares, $invalidShares";
  }

  Worker operator +(Worker other){
    num? valid = validShares != null ?
    (other.validShares != null ?
    validShares! + other.validShares! : validShares)
        : other.validShares;

    num? stale = staleShares != null ?
    (other.staleShares != null ?
    staleShares! + other.staleShares! : staleShares)
        : other.staleShares;

    num? invalid = invalidShares != null ?
    (other.invalidShares != null ?
    invalidShares! + other.invalidShares! : invalidShares)
        : other.invalidShares;


    return Worker(
      averageEffectiveHashrate: other.averageEffectiveHashrate,
      currentEffectiveHashrate: other.currentEffectiveHashrate,
      reportedHashrate: other.reportedHashrate,
      count: other.count,
      isOnline: other.isOnline,
      lastSeen: other.lastSeen,
      name: other.name,

      validShares: valid,
      staleShares: stale,
      invalidShares: invalid
    );
  }

}
