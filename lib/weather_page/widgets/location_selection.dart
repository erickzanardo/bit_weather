import 'package:flutter/material.dart';
import 'package:bit_weather/l10n/l10n.dart';

class LocationSelection extends StatefulWidget {
  LocationSelection({
    required this.onSelect,
  });

  final void Function(String) onSelect;

  @override
  State<StatefulWidget> createState() {
    return _LocationSelectionState();
  }
}

class _LocationSelectionState extends State<LocationSelection> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onSelect() {
    widget.onSelect(_controller.text);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Dialog(
      child: Column(
        children: [
          TextField(
            key: const Key('city_text_field'),
            controller: _controller,
          ),
          ElevatedButton(
            onPressed: _onSelect,
            child: Text(l10n.searchButtonLabel),
          )
        ],
      ),
    );
  }
}
