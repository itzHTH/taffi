class NotificationModel {
  String? id;
  String? title;
  String? message;
  bool? isRead;
  DateTime? createdAt;

  NotificationModel({this.id, this.title, this.message, this.isRead, this.createdAt});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    message = json['message'];
    isRead = json['isRead'];
    createdAt = DateTime.parse(json['createdAt']);
  }

  NotificationModel copyWith({
    String? id,
    String? title,
    String? message,
    bool? isRead,
    DateTime? createdAt,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      title: title ?? this.title,
      message: message ?? this.message,
      isRead: isRead ?? this.isRead,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['message'] = message;
    data['isRead'] = isRead;
    data['createdAt'] = createdAt;
    return data;
  }
}
