// Big thanks to
// https://javiercbk.github.io/json_to_dart/
// for his nice tool!


class MinerDetailsResponse {
  String? error;
  MinerDetailsResponseResult? result;

  MinerDetailsResponse({this.error, this.result});

  MinerDetailsResponse.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    result =
    json['result'] != null ? MinerDetailsResponseResult.fromJson(json['result']) : null;
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

class MinerDetailsResponseResult {
  //"N/A"
  String? clientIPAddress;
  int? currentNetworkFeePrice;
  int? firstJoined;
  // "ipAddress": "*.*.*.102"
  String? ipAddress;
  int? maxFeePrice;
  String? network;
  MinerDetailsNotificationPreferences? notificationPreferences;
  MinerDetailsNotifications? notifications;
  int? payoutLimit;

  MinerDetailsResponseResult(
      {this.clientIPAddress,
        this.currentNetworkFeePrice,
        this.firstJoined,
        this.ipAddress,
        this.maxFeePrice,
        this.network,
        this.notificationPreferences,
        this.notifications,
        this.payoutLimit});

  MinerDetailsResponseResult.fromJson(Map<String, dynamic> json) {
    clientIPAddress = json['clientIPAddress'];
    currentNetworkFeePrice = json['currentNetworkFeePrice'];
    firstJoined = json['firstJoined'];
    ipAddress = json['ipAddress'];
    maxFeePrice = json['maxFeePrice'];
    network = json['network'];
    notificationPreferences = json['notificationPreferences'] != null
        ? MinerDetailsNotificationPreferences.fromJson(json['notificationPreferences'])
        : null;
    notifications = json['notifications'] != null
        ? MinerDetailsNotifications.fromJson(json['notifications'])
        : null;
    payoutLimit = json['payoutLimit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['clientIPAddress'] = clientIPAddress;
    data['currentNetworkFeePrice'] = currentNetworkFeePrice;
    data['firstJoined'] = firstJoined;
    data['ipAddress'] = ipAddress;
    data['maxFeePrice'] = maxFeePrice;
    data['network'] = network;
    if (notificationPreferences != null) {
      data['notificationPreferences'] = notificationPreferences!.toJson();
    }
    if (notifications != null) {
      data['notifications'] = notifications!.toJson();
    }
    data['payoutLimit'] = payoutLimit;
    return data;
  }
}

class MinerDetailsNotificationPreferences {
  bool? workersOfflineNotifications;
  bool? payoutNotifications;
  int? workerOfflineDetectionDuration;

  MinerDetailsNotificationPreferences(
      {this.workersOfflineNotifications,
        this.payoutNotifications,
        this.workerOfflineDetectionDuration});

  MinerDetailsNotificationPreferences.fromJson(Map<String, dynamic> json) {
    workersOfflineNotifications = json['workersOfflineNotifications'];
    payoutNotifications = json['payoutNotifications'];
    workerOfflineDetectionDuration = json['workerOfflineDetectionDuration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['workersOfflineNotifications'] = workersOfflineNotifications;
    data['payoutNotifications'] = payoutNotifications;
    data['workerOfflineDetectionDuration'] = workerOfflineDetectionDuration;
    return data;
  }
}

class MinerDetailsNotifications {
  //"email": "tes*@tes*.de" for test@test.de
  String? email;

  MinerDetailsNotifications({this.email});

  MinerDetailsNotifications.fromJson(Map<String, dynamic> json) {
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    return data;
  }
}
