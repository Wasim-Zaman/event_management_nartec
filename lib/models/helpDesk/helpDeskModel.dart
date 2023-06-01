// ignore_for_file: file_names
class HelpDeskModel {
  int? deskID;
  String? firstName;
  String? lastName;
  String? email;
  String? issue;
  String? detail;
  int? ticketNo;

  HelpDeskModel(
      {this.deskID,
      this.firstName,
      this.lastName,
      this.email,
      this.issue,
      this.detail,
      this.ticketNo});

  HelpDeskModel.fromJson(Map<String, dynamic> json) {
    deskID = json['deskID'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    issue = json['issue'];
    detail = json['detail'];
    ticketNo = json['ticket_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['deskID'] = deskID;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['issue'] = issue;
    data['detail'] = detail;
    data['ticket_no'] = ticketNo;
    return data;
  }
}
