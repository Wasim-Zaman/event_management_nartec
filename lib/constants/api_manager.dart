import 'package:http/http.dart' as http;

class ApiManager {
  getRequest(var url) async {
    var response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': '',
      },
    );

    if (response.statusCode == 200 ||
        response.statusCode == 400 ||
        response.statusCode == 401) {
      return response;
    } else {
      return null;
    }
  }

  putRequest(var body, var url) async {
    var response = await http.put(
      Uri.parse(url),
      body: body,
      headers: {
        'Authorization': '',
      },
    );

    if (response.statusCode == 200 || response.statusCode == 401) {
      return response;
    } else {
      return null;
    }
  }

  postRequest(var body, var url) async {
    var response = await http.post(
      Uri.parse(url),
      body: body,
      headers: {
        'Authorization': '',
      },
    );

    if (response.statusCode == 200 || response.statusCode == 400) {
      return response;
    } else {
      return null;
    }
  }
}
