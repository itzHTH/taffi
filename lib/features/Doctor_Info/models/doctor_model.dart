import 'package:taffi/features/Doctor_Info/models/schedule_day_model.dart';

class DoctorModel {
  String? id;
  String? name;
  String? bio;
  String? specialtyName;
  String? location;
  double? rate;
  int? experienceYears;
  String? imageUrl;
  bool? isActive;
  List<ScheduleDayModel>? scheduleDays;

  DoctorModel({
    this.id,
    this.name,
    this.bio,
    this.specialtyName,
    this.location,
    this.rate,
    this.experienceYears,
    this.imageUrl,
    this.isActive,
  });

  DoctorModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    bio = json['bio'];
    specialtyName = json['specialtyName'];
    location = json['location'];
    rate = json['rate'];
    experienceYears = json['experienceYears'];
    imageUrl = "https://taafi.ddns.net/${json['imageUrl']}";
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['bio'] = bio;
    data['specialtyName'] = specialtyName;
    data['location'] = location;
    data['rate'] = rate;
    data['experienceYears'] = experienceYears;
    data['imageUrl'] = imageUrl;
    data['isActive'] = isActive;
    return data;
  }
}
