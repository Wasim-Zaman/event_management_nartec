class EaglesClubModel {
  String? lattitiude;
  String? longitude;

  EaglesClubModel({this.lattitiude, this.longitude});

  EaglesClubModel.fromJson(Map<String, dynamic> json) {
    lattitiude = json['lattitiude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lattitiude'] = lattitiude;
    data['longitude'] = longitude;
    return data;
  }
}
