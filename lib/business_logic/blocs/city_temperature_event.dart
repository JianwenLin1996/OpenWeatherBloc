import 'package:equatable/equatable.dart';

class CityTemperatureEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class GetCityTemperature extends CityTemperatureEvent {
  final String cityName;
  GetCityTemperature({
    required this.cityName,
  });
  @override
  // TODO: implement props
  List<Object?> get props => [cityName];
}

class ResetCityTemperature extends CityTemperatureEvent {}
