class Barangays {
  int? barangayID;
  String? barangayName;
  int? tblCitiesID;

  Barangays({this.barangayID, this.barangayName, this.tblCitiesID});

  Barangays.fromJson(Map<String, dynamic> json) {
    barangayID = json['barangayID'];
    barangayName = json['barangayName'];
    tblCitiesID = json['tblCitiesID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['barangayID'] = this.barangayID;
    data['barangayName'] = this.barangayName;
    data['tblCitiesID'] = this.tblCitiesID;
    return data;
  }
}
