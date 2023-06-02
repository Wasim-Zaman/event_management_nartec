class ProfileModel {
  int? memberID;
  String? firstName;
  String? lastName;
  String? streetAddress;
  String? barangay;
  String? province;
  String? city;
  String? clubName;
  String? clubRegion;
  String? clubPresident;
  String? date;
  String? peID;
  String? email;
  String? password;
  String? status;
  String? lattitiude;
  String? longitude;
  String? governmentIDImage;
  String? selfieIDImage;
  String? suffix;

  ProfileModel(
      {this.memberID,
      this.firstName,
      this.lastName,
      this.streetAddress,
      this.barangay,
      this.province,
      this.city,
      this.clubName,
      this.clubRegion,
      this.clubPresident,
      this.date,
      this.peID,
      this.email,
      this.password,
      this.status,
      this.lattitiude,
      this.longitude,
      this.governmentIDImage,
      this.selfieIDImage,
      this.suffix});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    memberID = json['memberID'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    streetAddress = json['street_address'];
    barangay = json['barangay'];
    province = json['province'];
    city = json['city'];
    clubName = json['club_name'];
    clubRegion = json['club_region'];
    clubPresident = json['club_president'];
    date = json['date'];
    peID = json['pe_ID'];
    email = json['email'];
    password = json['password'];
    status = json['status'];
    lattitiude = json['lattitiude'];
    longitude = json['longitude'];
    governmentIDImage = json['governmentIDImage'];
    selfieIDImage = json['selfieIDImage'];
    suffix = json['Suffix'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['memberID'] = this.memberID;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['street_address'] = this.streetAddress;
    data['barangay'] = this.barangay;
    data['province'] = this.province;
    data['city'] = this.city;
    data['club_name'] = this.clubName;
    data['club_region'] = this.clubRegion;
    data['club_president'] = this.clubPresident;
    data['date'] = this.date;
    data['pe_ID'] = this.peID;
    data['email'] = this.email;
    data['password'] = this.password;
    data['status'] = this.status;
    data['lattitiude'] = this.lattitiude;
    data['longitude'] = this.longitude;
    data['governmentIDImage'] = this.governmentIDImage;
    data['selfieIDImage'] = this.selfieIDImage;
    data['Suffix'] = this.suffix;
    return data;
  }
}
