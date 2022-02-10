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
}
