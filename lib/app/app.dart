import 'package:bit_weather/models/cache.dart';
import 'package:bit_weather/models/settings.dart';
import 'package:bit_weather/repositories/cache_repository.dart';
import 'package:bit_weather/repositories/weather_repository.dart';
import 'package:bit_weather/settings/bloc/settings_bloc.dart';
import 'package:bit_weather/settings/bloc/settings_event.dart';
import 'package:bit_weather/settings/bloc/settings_state.dart';
import 'package:bit_weather/settings/widgets/settings_panel.dart';
import 'package:bit_weather/weather_page/bloc/weather_bloc.dart';
import 'package:bit_weather/weather_page/weather_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:bit_weather/l10n/l10n.dart';

class App extends StatelessWidget {
  App({
    Key? key,
    required this.weatherRepository,
    required this.cacheRepository,
  }) : super(key: key);

  final WeatherRepository weatherRepository;
  final CacheRepository cacheRepository;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Cache>(
      future: cacheRepository.load(),
      builder: (_, snapshot) {
        if (snapshot.hasData) {
          final cache = snapshot.data!;
          return BlocProvider(
            create: (_) => SettingsBloc(
              cacheRepository: cacheRepository,
              initialSettings: cache.settings,
            ),
            child: BlocBuilder<SettingsBloc, SettingsState>(
              builder: (_, state) {
                return MaterialApp(
                  theme: ThemeData(
                    accentColor: const Color(0xFF13B9FF),
                    appBarTheme: const AppBarTheme(color: Color(0xFF13B9FF)),
                  ),
                  localizationsDelegates: [
                    AppLocalizations.delegate,
                    GlobalMaterialLocalizations.delegate,
                  ],
                  supportedLocales: AppLocalizations.supportedLocales,
                  locale:
                      Locale(state.settings.flag == Flag.br ? 'pt' : 'en', ''),
                  home: Scaffold(
                    body: BlocProvider(
                      create: (context) => WeatherBloc(
                        weatherRepository: weatherRepository,
                        cacheRepository: cacheRepository,
                        initialWeather: cache.weatherLocation,
                      ),
                      child: WeatherPage(settings: state.settings),
                    ),
                    floatingActionButton: Builder(builder: (context) {
                      // Using builder here as we need the context from our
                      // parent Scaffold to show the bottom sheet
                      return FloatingActionButton(
                        key: const Key('open_settings_button'),
                        child: const Icon(Icons.settings),
                        onPressed: () {
                          showBottomSheet(
                            context: context,
                            builder: (context) {
                              return SettingsPanel(
                                onSave: (settings) {
                                  BlocProvider.of<SettingsBloc>(context).add(
                                    UpdateSettings(settings),
                                  );
                                },
                                currentSettings: state.settings,
                              );
                            },
                          );
                        },
                      );
                    }),
                  ),
                );
              },
            ),
          );
        }

        return Container();
      },
    );
  }
}
