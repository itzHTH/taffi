class ScheduleDayModel {
  String? dayOfWeek;
  String? startTime;
  String? endTime;
  bool? isAvailable;

  ScheduleDayModel({this.dayOfWeek, this.startTime, this.endTime, this.isAvailable});

  ScheduleDayModel.fromJson(Map<String, dynamic> json) {
    dayOfWeek = json['dayOfWeek'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    isAvailable = json['isAvailable'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['dayOfWeek'] = dayOfWeek;
    data['startTime'] = startTime;
    data['endTime'] = endTime;
    data['isAvailable'] = isAvailable;
    return data;
  }
}
