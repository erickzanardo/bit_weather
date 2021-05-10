import 'package:bit_weather/repositories/weather_repository.dart';
import 'package:bit_weather/settings/bloc/settings_bloc.dart';
import 'package:bit_weather/settings/bloc/settings_state.dart';
import 'package:bit_weather/settings/bloc/widgets/settings_panel.dart';
import 'package:bit_weather/weather_page/bloc/weather_bloc.dart';
import 'package:bit_weather/weather_page/weather_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:bit_weather/l10n/l10n.dart';

class App extends StatelessWidget {
  App({
    Key? key,
    required this.repository,
  }) : super(key: key);

  final WeatherRepository repository;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SettingsBloc(),
      child: MaterialApp(
        theme: ThemeData(
          accentColor: const Color(0xFF13B9FF),
          appBarTheme: const AppBarTheme(color: Color(0xFF13B9FF)),
        ),
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        home: BlocBuilder<SettingsBloc, SettingsState>(
          builder: (_, state) {
            return Scaffold(
              body: BlocProvider(
                create: (context) => WeatherBloc(repository: repository),
                child: WeatherPage(),
              ),
              floatingActionButton: Builder(builder: (context) {
                // Using builder here as we need the context from our parent
                // Scaffold to show the bottom sheet
                return FloatingActionButton(
                  key: const Key('open_settings_button'),
                  child: const Icon(Icons.settings),
                  onPressed: () {
                    showBottomSheet(
                      context: context,
                      builder: (_) {
                        return SettingsPanel(
                          onSave: (settings) {
                            // TODO
                          },
                          currentSettings: state.settings,
                        );
                      },
                    );
                  },
                );
              }),
            );
          },
        ),
      ),
    );
  }
}
