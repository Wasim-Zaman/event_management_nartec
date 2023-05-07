class Provinces {
  String? provincename;

  Provinces({this.provincename});

  Provinces.fromJson(Map<String, dynamic> json) {
    provincename = json['provincename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['provincename'] = provincename;
    return data;
  }
}
