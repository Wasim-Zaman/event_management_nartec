class Cities {
  int? tblCitiesID;
  String? citiyname;
  int? provanceID;

  Cities({this.tblCitiesID, this.citiyname, this.provanceID});

  Cities.fromJson(Map<String, dynamic> json) {
    tblCitiesID = json['tblCitiesID'];
    citiyname = json['Citiyname'];
    provanceID = json['provanceID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tblCitiesID'] = this.tblCitiesID;
    data['Citiyname'] = this.citiyname;
    data['provanceID'] = this.provanceID;
    return data;
  }
}
