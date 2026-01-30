class MessageModel {
  String? id;
  String? content;
  String? timestamp;
  bool? isUserMessage;

  MessageModel({this.id, this.content, this.timestamp, this.isUserMessage});

  MessageModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    content = json['content'];
    timestamp = json['timestamp'];
    isUserMessage = json['isUserMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['content'] = content;
    data['timestamp'] = timestamp;
    data['isUserMessage'] = isUserMessage;
    return data;
  }
}
