class SpecialtyModel {
  String? id;
  String? name;
  String? iconUrl;

  SpecialtyModel({this.id, this.name, this.iconUrl});

  SpecialtyModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    iconUrl = "https://taafi.ddns.net/${json['iconUrl']}";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['iconUrl'] = iconUrl;
    return data;
  }
}
