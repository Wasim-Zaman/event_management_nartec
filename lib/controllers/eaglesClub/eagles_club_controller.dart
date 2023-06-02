import 'dart:convert';

import 'package:event_management/common/constants/api_manager.dart';
import 'package:event_management/common/constants/url.dart';
import 'package:event_management/models/EaglesClubModel/eagles_club_model.dart';

class EaglesClubController {
  static Future<List<EaglesClubModel>> getLatLong() async {
    List<EaglesClubModel> model = [];
    try {
      var response =
          await ApiManager.getRequest("${URL.baseUrl}ListOFAllLocation");
      if (response.statusCode == 200) {
        var data = json.decode(response.body) as Map;
        data["recordsets"][0].forEach((element) {
          model.add(EaglesClubModel.fromJson(element));
        });
      } else {
        throw Exception('Bad Request');
      }
    } catch (error) {
      rethrow;
    }
    return model;
  }
}
