import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bit_weather/weather_page/widgets/location_selection.dart';
import 'package:bit_weather/weather_page/widgets/weather_view.dart';
import 'package:bit_weather/weather_page/bloc/weather_bloc.dart';
import 'package:bit_weather/weather_page/bloc/weather_state.dart';
import 'package:bit_weather/weather_page/widgets/empty_view.dart';
import 'package:bit_weather/weather_page/widgets/error_view.dart';
import 'package:bit_weather/weather_page/widgets/not_found_view.dart';
import 'package:bit_weather/weather_page/widgets/loading_view.dart';
import 'package:bit_weather/weather_page/bloc/weather_event.dart';

class WeatherPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _WeatherPageState();
  }
}

class _WeatherPageState extends State<WeatherPage> {
  Completer<void>? _refreshCompleter;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _onRefresh(String city) {
    BlocProvider.of<WeatherBloc>(context).add(
      WeatherRefresh(city),
    );
    final completer = _refreshCompleter = Completer<void>();
    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 10,
          right: 10,
          child: FloatingActionButton(
            key: const Key('add_city_button'),
            child: const Icon(Icons.search),
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) {
                  return LocationSelection(
                    onSelect: (String city) {
                      BlocProvider.of<WeatherBloc>(context).add(
                        WeatherSearch(city),
                      );
                    },
                  );
                },
              );
            },
          ),
        ),
        Positioned.fill(
          child: Center(
            child: BlocConsumer<WeatherBloc, WeatherState>(
              listener: (context, state) {
                if (state is WeatherLoaded) {
                  _refreshCompleter?.complete();
                }
              },
              builder: (context, state) {
                if (state is WeatherLoaded) {
                  return RefreshIndicator(
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: WeatherView(information: state.weather),
                    ),
                    onRefresh: () => _onRefresh(state.weather.location.title),
                  );
                }

                if (state is WeatherLoading) {
                  return const LoadingView();
                }

                if (state is WeatherLoadingFailed) {
                  return const ErrorView();
                }

                if (state is WeatherNotFound) {
                  return const NotFoundView();
                }

                return const EmptyView();
              },
            ),
          ),
        ),
      ],
    );
  }
}
