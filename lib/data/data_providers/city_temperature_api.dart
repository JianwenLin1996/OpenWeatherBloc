import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:bloc_test/utils/constants/globals.dart' as globals;

class CityTemperatureAPI {
  Future<http.Response> getCityTemperatureAPI(String city) async {
    var queryParameters = {'q': city, 'appid': globals.appID};
    var url = Uri.https(globals.apiBaseURL, globals.apiSubURL, queryParameters);
    print(url);
    try {
      http.Response apiResponse = await http.get(
        url,
        headers: {},
      );

      return apiResponse;
    } on SocketException catch (_) {
      // catch internet connection error
      http.Response errorResponse =
          http.Response("{status_message : No internet connection.}", 503);

      return errorResponse;
    } catch (e) {
      http.Response errorResponse =
          http.Response("{status_message : $e }", 503);

      return errorResponse;
    }
  }
}
