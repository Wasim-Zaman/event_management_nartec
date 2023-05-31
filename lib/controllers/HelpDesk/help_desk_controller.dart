import 'package:event_management/common/constants/api_manager.dart';
import 'package:event_management/common/constants/url.dart';

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
}
