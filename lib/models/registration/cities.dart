class Cities {
  String? citiyname;

  Cities({this.citiyname});

  Cities.fromJson(Map<String, dynamic> json) {
    citiyname = json['Citiyname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Citiyname'] = citiyname;
    return data;
  }
}
