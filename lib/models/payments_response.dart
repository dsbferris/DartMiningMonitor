// Big thanks to
// https://javiercbk.github.io/json_to_dart/
// for his nice tool!

import 'package:equatable/equatable.dart';

class PaymentsResponse {
  String? error;
  PaymentsResponseResult? result;

  PaymentsResponse({this.error, this.result});

  PaymentsResponse.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    result =
    json['result'] != null ? PaymentsResponseResult.fromJson(json['result']) : null;
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

class PaymentsResponseResult {
  num? countervalue;
  num? totalItems;
  num? totalPages;
  List<Payout>? data;

  PaymentsResponseResult({this.countervalue, this.totalItems, this.totalPages, this.data});

  PaymentsResponseResult.fromJson(Map<String, dynamic> json) {
    countervalue = json['countervalue'];
    totalItems = json['totalItems'];
    totalPages = json['totalPages'];
    if (json['data'] != null) {
      data = <Payout>[];
      json['data'].forEach((v) {
        data!.add(Payout.fromJson(v));
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

class Payout extends Equatable{
  late final String? hash;
  late final num? timestamp;
  late final num? value;
  late final num? fee;
  late final num? feePercent;
  late final num? duration;
  late final bool? confirmed;
  late final num? confirmedTimestamp;

  Payout(
      {this.hash,
        this.timestamp,
        this.value,
        this.fee,
        this.feePercent,
        this.duration,
        this.confirmed,
        this.confirmedTimestamp});

  Payout.fromJson(Map<String, dynamic> json) {
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

  @override
  List<Object?> get props =>
      [hash, timestamp, value, fee, feePercent, duration, confirmed, confirmedTimestamp];

}
