import 'package:equatable/equatable.dart';

import 'package:bloc_test/data/models/city_temperature.dart';

class CityTemperatureState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class NotSearchingState extends CityTemperatureState {}

class SearchingState extends CityTemperatureState {}

class ErrorState extends CityTemperatureState {}

class SearchedState extends CityTemperatureState {
  final CityTemperature cityTemperature;
  SearchedState({
    required this.cityTemperature,
  });
  @override
  // TODO: implement props
  List<Object?> get props => [cityTemperature];
}
