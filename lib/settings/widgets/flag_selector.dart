import 'package:bit_weather/models/settings.dart';
import 'package:flutter/material.dart';

class FlagSelector extends StatelessWidget {
  FlagSelector({
    required this.flag,
    required this.onChange,
  });

  final Flag flag;
  final void Function(Flag) onChange;

  void _select(Flag flag) {
    onChange(flag);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _FlagImage(
            key: const Key('br_option'),
            url: 'assets/images/br.png',
            selected: flag == Flag.br,
            onSelect: () => _select(Flag.br),
          ),
          _FlagImage(
            key: const Key('us_option'),
            url: 'assets/images/us.png',
            selected: flag == Flag.us,
            onSelect: () => _select(Flag.us),
          ),
        ],
      ),
    );
  }
}

class _FlagImage extends StatelessWidget {
  _FlagImage({
    Key? key,
    required this.url,
    required this.selected,
    required this.onSelect,
  }): super(key: key);

  final String url;
  final bool selected;
  final VoidCallback onSelect;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelect,
      child: Container(
        padding: const EdgeInsets.all(2),
        child: Image.asset(url, width: 40),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 2,
              color: selected
                  ? Theme.of(context).primaryColor
                  : Colors.transparent,
            ),
          ),
        ),
      ),
    );
  }
}
