import 'package:counter_app/services/theme_manager.dart';
import 'package:flutter/material.dart';

class TimePickerItem extends StatelessWidget {
  final ThemeNotifier theme;
  final int value;
  final String unit;
  final VoidCallback onAdd;
  final VoidCallback onMinus;
  const TimePickerItem({
    Key? key,
    required this.theme,
    this.value = 0,
    this.unit = '',
    required this.onAdd,
    required this.onMinus,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onAdd,
          child: const Icon(Icons.keyboard_arrow_up),
        ),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: theme.getTheme.primaryColor),
            borderRadius: BorderRadius.circular(7),
          ),
          child: Center(
            child: Text(
              "${value.toString().padLeft(2, '0')} $unit",
              style: Theme.of(context)
                  .textTheme
                  .subtitle1!
                  .copyWith(color: theme.getTheme.primaryColor),
            ),
          ),
        ),
        InkWell(
          onTap: onMinus,
          child: const Icon(Icons.keyboard_arrow_down),
        ),
      ],
    );
  }
}
