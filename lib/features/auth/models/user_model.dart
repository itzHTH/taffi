class UserModel {
  String? id;
  String? fullName;
  String? userName;
  String? email;
  String? phoneNumber;
  String? governorate;
  int? age;

  UserModel({
    this.id,
    this.fullName,
    this.userName,
    this.email,
    this.phoneNumber,
    this.governorate,
    this.age,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['fullName'];
    userName = json['userName'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    governorate = json['governorate'];
    age = json['age'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['fullName'] = fullName;
    data['userName'] = userName;
    data['email'] = email;
    data['phoneNumber'] = phoneNumber;
    data['governorate'] = governorate;
    data['age'] = age;
    return data;
  }
}
