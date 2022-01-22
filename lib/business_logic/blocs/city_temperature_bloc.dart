import 'package:bloc/bloc.dart';
import 'package:bloc_test/business_logic/blocs/city_temperature_event.dart';
import 'package:bloc_test/business_logic/blocs/city_temperature_state.dart';
import 'package:bloc_test/data/models/city_temperature.dart';
import 'package:bloc_test/data/repositories/city_temperature_repository.dart';

class CityTemperatureBloc
    extends Bloc<CityTemperatureEvent, CityTemperatureState> {
  CityTemperatureBloc() : super(NotSearchingState()) {
    on<GetCityTemperature>((event, emit) async {
      // TODO: implement event handler
      emit(SearchingState());
      try {
        var _repoResult = await _getCityTemperature(event.cityName);
        if (_repoResult['status_code'] == 200) {
          final CityTemperature _repoCityTemperature = _repoResult['data'];
          emit(SearchedState(cityTemperature: _repoCityTemperature));
        } else {
          emit(ErrorState());
        }
      } catch (e) {
        emit(ErrorState());
      }
    });
    on<ResetCityTemperature>((event, emit) {
      // TODO: implement event handler
      emit(NotSearchingState());
    });
  }

  final CityTemperatureRepository cityTemperatureRepo =
      CityTemperatureRepository();

  // @override
  // Stream<CityTemperatureState> mapEventToState(
  //     CityTemperatureEvent event) async* {
  //   if (event is GetCityTemperature) {
  //     yield SearchingState();
  //     try {
  //       var _repoResult = await _getCityTemperature(event.cityName);
  //       if (_repoResult['status_code'] == 200) {
  //         final CityTemperature _repoCityTemperature = _repoResult['data'];
  //         yield SearchedState(cityTemperature: _repoCityTemperature);
  //       } else {
  //         yield ErrorState();
  //       }
  //     } catch (e) {
  //       yield ErrorState();
  //     }
  //   } else if (event is ResetCityTemperature) {
  //     yield NotSearchingState();
  //   }
  // }

  Future<Map<String, dynamic>> _getCityTemperature(String city) async {
    final _result = await cityTemperatureRepo.getCityTemperature(city);
    return _result;
  }
}
