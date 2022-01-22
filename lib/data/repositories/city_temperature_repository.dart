import 'package:bloc_test/data/data_providers/city_temperature_api.dart';
import 'package:bloc_test/data/models/city_temperature.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class CityTemperatureRepository {
  final CityTemperatureAPI cityTemperatureAPI = CityTemperatureAPI();

  Future<Map<String, dynamic>> getCityTemperature(String city) async {
    final http.Response rawCityTemperature =
        await cityTemperatureAPI.getCityTemperatureAPI(city);
    if (rawCityTemperature.statusCode == 200) {
      // some processes if returned data is not JSON
      final CityTemperature cityTemperature =
          CityTemperature.fromJson(rawCityTemperature.body);
      return {
        'status_code': rawCityTemperature.statusCode,
        'data': cityTemperature
      };
    } else {
      var responseBody =
          convert.jsonDecode(rawCityTemperature.body) as Map<String, dynamic>;
      String errorMessage = responseBody['status_message'];
      return {
        'status_code': rawCityTemperature.statusCode,
        'data': errorMessage
      };
    }
  }
}
