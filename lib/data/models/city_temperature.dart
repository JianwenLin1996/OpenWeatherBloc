import 'dart:convert';

class CityTemperature {
  String cityName;
  double cityTemp;

  CityTemperature({
    required this.cityName,
    required this.cityTemp,
  });

  Map<String, dynamic> toMap() {
    return {
      'cityName': cityName,
      'cityTemp': cityTemp,
    };
  }

  factory CityTemperature.fromMap(Map<String, dynamic> map) {
    double tempCityTemperature = map['main']?['temp']?.toDouble() ?? 0.0;

    return CityTemperature(
      cityName: map['name'] ?? '',
      cityTemp: tempCityTemperature - 273.15,
      //if either ['main'] or ['temp'] is null, toDouble() will not be called
    );
  }

  String toJson() => json.encode(toMap());

  factory CityTemperature.fromJson(String source) =>
      CityTemperature.fromMap(json.decode(source));
}
