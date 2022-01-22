import 'package:bloc_test/business_logic/blocs/city_temperature_bloc.dart';
import 'package:bloc_test/business_logic/blocs/city_temperature_event.dart';
import 'package:bloc_test/business_logic/blocs/city_temperature_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController cityController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider<CityTemperatureBloc>(
      create: (context) => CityTemperatureBloc(),
      child: Scaffold(
          appBar: AppBar(
            title: Text('Open Weather Bloc'),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 20),
            child: Center(
              child: Column(
                children: [
                  Builder(builder: (context) {
                    return TextFormField(
                      controller: cityController,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.search),
                          hintText: 'Search City',
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)))),
                      onEditingComplete: () {
                        BlocProvider.of<CityTemperatureBloc>(context).add(
                            GetCityTemperature(cityName: cityController.text));
                      },
                    );
                  }),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                        child: BlocBuilder<CityTemperatureBloc,
                            CityTemperatureState>(builder: (context, state) {
                          if (state is SearchedState) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(state.cityTemperature.cityName),
                                Text(state.cityTemperature.cityTemp
                                        .toStringAsFixed(2) +
                                    ' \u2103')
                              ],
                            );
                          } else if (state is ErrorState) {
                            return const Text('Error fetching data.');
                          } else if (state is SearchingState) {
                            return const Text('Searching ...');
                          } else if (state is NotSearchingState) {
                            return const Text('Key in city name.');
                          } else {
                            return Container();
                          }
                        })),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
