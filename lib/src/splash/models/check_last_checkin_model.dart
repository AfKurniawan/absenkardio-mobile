class CheckLastCheckinModel {
  bool error;
  String messages;

  CheckLastCheckinModel({this.error, this.messages});

  CheckLastCheckinModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    messages = json['messages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['messages'] = this.messages;
    return data;
  }
}
