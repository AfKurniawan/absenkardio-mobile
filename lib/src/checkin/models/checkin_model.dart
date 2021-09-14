class CheckinModel {
  bool error;
  String messages;
  Checkin checkin;

  CheckinModel({this.error, this.messages, this.checkin});

  CheckinModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    messages = json['messages'];
    checkin =
    json['checkin'] != null ? new Checkin.fromJson(json['checkin']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['messages'] = this.messages;
    if (this.checkin != null) {
      data['checkin'] = this.checkin.toJson();
    }
    return data;
  }
}

class Checkin {
  String idno;
  String date;
  String employee;
  String timein;
  String location;
  String statusTimein;
  String reason;
  String selfie;

  Checkin(
      {this.idno,
        this.date,
        this.employee,
        this.timein,
        this.location,
        this.statusTimein,
        this.reason,
        this.selfie});

  Checkin.fromJson(Map<String, dynamic> json) {
    idno = json['idno'];
    date = json['date'];
    employee = json['employee'];
    timein = json['timein'];
    location = json['location'];
    statusTimein = json['status_timein'];
    reason = json['reason'];
    selfie = json['selfie'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idno'] = this.idno;
    data['date'] = this.date;
    data['employee'] = this.employee;
    data['timein'] = this.timein;
    data['location'] = this.location;
    data['status_timein'] = this.statusTimein;
    data['reason'] = this.reason;
    data['selfie'] = this.selfie;
    return data;
  }
}
