import 'dart:convert';

import 'package:event_management/common/constants/api_manager.dart';
import 'package:event_management/common/constants/url.dart';
import 'package:event_management/models/helpDesk/helpDeskModel.dart';

class HelpDeskController {
  static Future<bool> postHelpDesk(body) async {
    try {
      var response = await ApiManager.postRequest(
        body,
        "${URL.baseUrl}tbl_post_help_desk",
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception("Failed to post help desk");
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<List<HelpDeskModel>> getHelpDesk() async {
    List<HelpDeskModel> model = [];
    try {
      var response =
          await ApiManager.getRequest("${URL.baseUrl}get_post_help_desk");
      if (response.statusCode == 200) {
        var data = json.decode(response.body) as Map;
        data["recordsets"][0].forEach((element) {
          model.add(HelpDeskModel.fromJson(element));
        });
      } else {
        throw Exception('Failed to load data!');
      }
    } catch (error) {
      rethrow;
    }
    return model;
  }
}
