class UserModel {
  bool error;
  String messages;
  User user;

  UserModel({this.error, this.messages, this.user});

  UserModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    messages = json['messages'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['messages'] = this.messages;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    return data;
  }
}

class User {
  String id;
  String firstname;
  String mi;
  String lastname;
  int age;
  String password;
  String gender;
  String emailaddress;
  String civilstatus;
  String height;
  String weight;
  String mobileno;
  String birthday;
  String nationalid;
  String birthplace;
  String homeaddress;
  String employmentstatus;
  String employmenttype;
  String avatar;
  String createdAt;
  String reference;
  String company;
  String department;
  String jobposition;
  String companyemail;
  String idno;
  String startdate;
  String dateregularized;
  String reason;
  int leaveprivilege;

  User(
      {this.id,
        this.firstname,
        this.mi,
        this.lastname,
        this.age,
        this.password,
        this.gender,
        this.emailaddress,
        this.civilstatus,
        this.height,
        this.weight,
        this.mobileno,
        this.birthday,
        this.nationalid,
        this.birthplace,
        this.homeaddress,
        this.employmentstatus,
        this.employmenttype,
        this.avatar,
        this.createdAt,
        this.reference,
        this.company,
        this.department,
        this.jobposition,
        this.companyemail,
        this.idno,
        this.startdate,
        this.dateregularized,
        this.reason,
        this.leaveprivilege});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstname = json['firstname'];
    mi = json['mi'];
    lastname = json['lastname'];
    age = json['age'];
    password = json['password'];
    gender = json['gender'];
    emailaddress = json['emailaddress'];
    civilstatus = json['civilstatus'];
    height = json['height'];
    weight = json['weight'];
    mobileno = json['mobileno'];
    birthday = json['birthday'];
    nationalid = json['nationalid'];
    birthplace = json['birthplace'];
    homeaddress = json['homeaddress'];
    employmentstatus = json['employmentstatus'];
    employmenttype = json['employmenttype'];
    avatar = json['avatar'];
    createdAt = json['created_at'];
    reference = json['reference'];
    company = json['company'];
    department = json['department'];
    jobposition = json['jobposition'];
    companyemail = json['companyemail'];
    idno = json['idno'];
    startdate = json['startdate'];
    dateregularized = json['dateregularized'];
    reason = json['reason'];
    leaveprivilege = json['leaveprivilege'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstname'] = this.firstname;
    data['mi'] = this.mi;
    data['lastname'] = this.lastname;
    data['age'] = this.age;
    data['password'] = this.password;
    data['gender'] = this.gender;
    data['emailaddress'] = this.emailaddress;
    data['civilstatus'] = this.civilstatus;
    data['height'] = this.height;
    data['weight'] = this.weight;
    data['mobileno'] = this.mobileno;
    data['birthday'] = this.birthday;
    data['nationalid'] = this.nationalid;
    data['birthplace'] = this.birthplace;
    data['homeaddress'] = this.homeaddress;
    data['employmentstatus'] = this.employmentstatus;
    data['employmenttype'] = this.employmenttype;
    data['avatar'] = this.avatar;
    data['created_at'] = this.createdAt;
    data['reference'] = this.reference;
    data['company'] = this.company;
    data['department'] = this.department;
    data['jobposition'] = this.jobposition;
    data['companyemail'] = this.companyemail;
    data['idno'] = this.idno;
    data['startdate'] = this.startdate;
    data['dateregularized'] = this.dateregularized;
    data['reason'] = this.reason;
    data['leaveprivilege'] = this.leaveprivilege;
    return data;
  }
}
