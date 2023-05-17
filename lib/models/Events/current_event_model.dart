class CurrentEventModel {
  String? id;
  String? eventName;
  String? eventDescription;
  String? location;
  String? locationArea;
  String? status;
  String? deletedAt;
  String? startDate;
  String? endDate;
  String? createdAt;
  String? updatedAt;

  CurrentEventModel(
      {this.id,
      this.eventName,
      this.eventDescription,
      this.location,
      this.locationArea,
      this.status,
      this.deletedAt,
      this.startDate,
      this.endDate,
      this.createdAt,
      this.updatedAt});

  CurrentEventModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    eventName = json['event_name'];
    eventDescription = json['event_description'];
    location = json['location'];
    locationArea = json['location_area'];
    status = json['status'];
    deletedAt = json['deleted_at'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['event_name'] = eventName;
    data['event_description'] = eventDescription;
    data['location'] = location;
    data['location_area'] = locationArea;
    data['status'] = status;
    data['deleted_at'] = deletedAt;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
