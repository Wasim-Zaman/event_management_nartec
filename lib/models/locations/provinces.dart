class Provinces {
  int? provinceID;
  String? provincename;
  int? tblcitiesID;

  Provinces({this.provinceID, this.provincename, this.tblcitiesID});

  Provinces.fromJson(Map<String, dynamic> json) {
    provinceID = json['provinceID'];
    provincename = json['provincename'];
    tblcitiesID = json['tblcitiesID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['provinceID'] = this.provinceID;
    data['provincename'] = this.provincename;
    data['tblcitiesID'] = this.tblcitiesID;
    return data;
  }
}
