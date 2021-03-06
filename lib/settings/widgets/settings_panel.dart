import 'package:bit_weather/models/settings.dart';
import 'package:bit_weather/settings/widgets/flag_selector.dart';
import 'package:flutter/material.dart';
import 'package:bit_weather/l10n/l10n.dart';

class SettingsPanel extends StatefulWidget {
  SettingsPanel({
    required this.onSave,
    required this.currentSettings,
  });

  final Settings currentSettings;

  final void Function(Settings) onSave;

  @override
  State<StatefulWidget> createState() {
    return _SettingsPanelState();
  }
}

class _SettingsPanelState extends State<SettingsPanel> {
  late bool _useCelsius;
  late Flag _flag;

  @override
  void initState() {
    _useCelsius = widget.currentSettings.units == UnitType.celsius;
    _flag = widget.currentSettings.flag;

    super.initState();
  }

  void _onSave() {
    widget.onSave(
      Settings(
        units: _useCelsius ? UnitType.celsius : UnitType.fahrenheit,
        flag: _flag,
      ),
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Container(
      height: 250,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(l10n.settings, style: Theme.of(context).textTheme.headline5),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(l10n.useCelsiusLabel),
              Switch(
                key: const Key('toggle_units_type'),
                value: _useCelsius,
                onChanged: (value) {
                  setState(() => _useCelsius = value);
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(l10n.language),
              FlagSelector(
                flag: _flag,
                onChange: (flag) {
                  setState(() => _flag = flag);
                },
              ),
            ],
          ),
          ElevatedButton(
            onPressed: _onSave,
            child: Text(l10n.save),
          )
        ],
      ),
    );
  }
}
