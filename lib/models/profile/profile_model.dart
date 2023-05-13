// ignore_for_file: unnecessary_getters_setters

class ProfileModel {
  int? _memberID;
  String? _firstName;
  String? _lastName;
  String? _streetAddress;
  String? _barangay;
  String? _province;
  String? _city;
  String? _clubName;
  String? _clubRegion;
  String? _clubPresident;
  String? _nationalPresident;
  String? _date;
  String? _peID;
  String? _clubSecretryName;
  int? _clubSecretryNO;
  String? _email;
  String? _password;

  ProfileModel(
      {int? memberID,
      String? firstName,
      String? lastName,
      String? streetAddress,
      String? barangay,
      String? province,
      String? city,
      String? clubName,
      String? clubRegion,
      String? clubPresident,
      String? nationalPresident,
      String? date,
      String? peID,
      String? clubSecretryName,
      int? clubSecretryNO,
      String? email,
      String? password}) {
    if (memberID != null) {
      _memberID = memberID;
    }
    if (firstName != null) {
      _firstName = firstName;
    }
    if (lastName != null) {
      _lastName = lastName;
    }
    if (streetAddress != null) {
      _streetAddress = streetAddress;
    }
    if (barangay != null) {
      _barangay = barangay;
    }
    if (province != null) {
      _province = province;
    }
    if (city != null) {
      _city = city;
    }
    if (clubName != null) {
      _clubName = clubName;
    }
    if (clubRegion != null) {
      _clubRegion = clubRegion;
    }
    if (clubPresident != null) {
      _clubPresident = clubPresident;
    }
    if (nationalPresident != null) {
      _nationalPresident = nationalPresident;
    }
    if (date != null) {
      _date = date;
    }
    if (peID != null) {
      _peID = peID;
    }
    if (clubSecretryName != null) {
      _clubSecretryName = clubSecretryName;
    }
    if (clubSecretryNO != null) {
      _clubSecretryNO = clubSecretryNO;
    }
    if (email != null) {
      _email = email;
    }
    if (password != null) {
      _password = password;
    }
  }

  int? get memberID => _memberID;
  set memberID(int? memberID) => _memberID = memberID;
  String? get firstName => _firstName;
  set firstName(String? firstName) => _firstName = firstName;
  String? get lastName => _lastName;
  set lastName(String? lastName) => _lastName = lastName;
  String? get streetAddress => _streetAddress;
  set streetAddress(String? streetAddress) => _streetAddress = streetAddress;
  String? get barangay => _barangay;
  set barangay(String? barangay) => _barangay = barangay;
  String? get province => _province;
  set province(String? province) => _province = province;
  String? get city => _city;
  set city(String? city) => _city = city;
  String? get clubName => _clubName;
  set clubName(String? clubName) => _clubName = clubName;
  String? get clubRegion => _clubRegion;
  set clubRegion(String? clubRegion) => _clubRegion = clubRegion;
  String? get clubPresident => _clubPresident;
  set clubPresident(String? clubPresident) => _clubPresident = clubPresident;
  String? get nationalPresident => _nationalPresident;
  set nationalPresident(String? nationalPresident) =>
      _nationalPresident = nationalPresident;
  String? get date => _date;
  set date(String? date) => _date = date;
  String? get peID => _peID;
  set peID(String? peID) => _peID = peID;
  String? get clubSecretryName => _clubSecretryName;
  set clubSecretryName(String? clubSecretryName) =>
      _clubSecretryName = clubSecretryName;
  int? get clubSecretryNO => _clubSecretryNO;
  set clubSecretryNO(int? clubSecretryNO) => _clubSecretryNO = clubSecretryNO;
  String? get email => _email;
  set email(String? email) => _email = email;
  String? get password => _password;
  set password(String? password) => _password = password;

  ProfileModel.fromJson(Map<String, dynamic> json) {
    _memberID = json['memberID'];
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    _streetAddress = json['street_address'];
    _barangay = json['barangay'];
    _province = json['province'];
    _city = json['city'];
    _clubName = json['club_name'];
    _clubRegion = json['club_region'];
    _clubPresident = json['club_president'];
    _nationalPresident = json['national_president'];
    _date = json['date'];
    _peID = json['pe_ID'];
    _clubSecretryName = json['club_secretry_name'];
    _clubSecretryNO = json['club_secretry_NO'];
    _email = json['email'];
    _password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['memberID'] = _memberID;
    data['first_name'] = _firstName;
    data['last_name'] = _lastName;
    data['street_address'] = _streetAddress;
    data['barangay'] = _barangay;
    data['province'] = _province;
    data['city'] = _city;
    data['club_name'] = _clubName;
    data['club_region'] = _clubRegion;
    data['club_president'] = _clubPresident;
    data['national_president'] = _nationalPresident;
    data['date'] = _date;
    data['pe_ID'] = _peID;
    data['club_secretry_name'] = _clubSecretryName;
    data['club_secretry_NO'] = _clubSecretryNO;
    data['email'] = _email;
    data['password'] = _password;
    return data;
  }
}
