class Provinces {
  String? citiyname;

  Provinces({this.citiyname});

  Provinces.fromJson(Map<String, dynamic> json) {
    citiyname = json['Citiyname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Citiyname'] = citiyname;
    return data;
  }
}
