// Big thanks to
// https://javiercbk.github.io/json_to_dart/
// for his nice tool!

class PayoutResponse {
  String? error;
  PayoutResponseResult? result;

  PayoutResponse({this.error, this.result});

  PayoutResponse.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    result =
    json['result'] != null ? PayoutResponseResult.fromJson(json['result']) : null;
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

class PayoutResponseResult {
  num? countervalue;
  num? totalItems;
  num? totalPages;
  List<PayoutResponseResultData>? data;

  PayoutResponseResult({this.countervalue, this.totalItems, this.totalPages, this.data});

  PayoutResponseResult.fromJson(Map<String, dynamic> json) {
    countervalue = json['countervalue'];
    totalItems = json['totalItems'];
    totalPages = json['totalPages'];
    if (json['data'] != null) {
      data = <PayoutResponseResultData>[];
      json['data'].forEach((v) {
        data!.add(PayoutResponseResultData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['countervalue'] = countervalue;
    data['totalItems'] = totalItems;
    data['totalPages'] = totalPages;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PayoutResponseResultData {
  String? hash;
  num? timestamp;
  num? value;
  num? fee;
  num? feePercent;
  num? duration;
  bool? confirmed;
  num? confirmedTimestamp;

  PayoutResponseResultData(
      {this.hash,
        this.timestamp,
        this.value,
        this.fee,
        this.feePercent,
        this.duration,
        this.confirmed,
        this.confirmedTimestamp});

  PayoutResponseResultData.fromJson(Map<String, dynamic> json) {
    hash = json['hash'];
    timestamp = json['timestamp'];
    value = json['value'];
    fee = json['fee'];
    feePercent = json['feePercent'];
    duration = json['duration'];
    confirmed = json['confirmed'];
    confirmedTimestamp = json['confirmedTimestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['hash'] = hash;
    data['timestamp'] = timestamp;
    data['value'] = value;
    data['fee'] = fee;
    data['feePercent'] = feePercent;
    data['duration'] = duration;
    data['confirmed'] = confirmed;
    data['confirmedTimestamp'] = confirmedTimestamp;
    return data;
  }
}
