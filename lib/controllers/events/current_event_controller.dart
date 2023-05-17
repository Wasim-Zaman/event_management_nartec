import 'dart:convert';

import 'package:event_management/constants/api_manager.dart';
import 'package:event_management/constants/url.dart';
import 'package:event_management/models/Events/current_event_model.dart';

class CurrentEventController {
  static Future<List<CurrentEventModel>> getCurrentEvents() async {
    List<CurrentEventModel> currentEvent = [];
    try {
      var response = await ApiManager.getRequest("${URL.baseUrl}getEventAll");
      if (response.statusCode == 200) {
        final List records = jsonDecode(response.body)['recordset'];
        currentEvent =
            records.map((e) => CurrentEventModel.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load data!');
      }
    } catch (error) {
      rethrow;
    }
    return currentEvent;
  }
}
