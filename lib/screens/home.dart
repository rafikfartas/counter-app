import 'package:animations/animations.dart';
import 'package:counter_app/services/counter_provider.dart';
import 'package:counter_app/services/theme_manager.dart';
import 'package:counter_app/theme/colors.dart';
import 'package:counter_app/widgets/circle_button.dart';
import 'package:counter_app/widgets/time_picker_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CounterProvider>(
      create: (ctx) => CounterProvider(this),
      child: Consumer2<ThemeNotifier, CounterProvider>(
        builder: (context, themeNotifier, counterProvider, child) {
          return Scaffold(
            appBar: _buildAppbar(themeNotifier),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Center(
                child: Column(
                  children: [
                    counterProvider.animationController.value > 0
                        ? _counterClock(counterProvider)
                        : _durationPicker(counterProvider),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _cancelButton(counterProvider),
                          _startButton(counterProvider),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  _buildAppbar(ThemeNotifier themeNotifier) {
    return AppBar(
      title: const Text('Counter app'),
      actions: [
        IconButton(
          onPressed: () {
            if (themeNotifier.getTheme.brightness == Brightness.dark) {
              themeNotifier.setLightMode();
            } else {
              themeNotifier.setDarkMode();
            }
          },
          icon: Icon(
            themeNotifier.getTheme.brightness == Brightness.dark
                ? Icons.wb_sunny_outlined
                : Icons.wb_sunny,
          ),
        ),
      ],
    );
  }

  _startButton(CounterProvider counterProvider) {
    return CircleButton(
      onTap: () {
        counterProvider.startPauseCounter();
      },
      text: counterProvider.isPlaying &&
              counterProvider.animationController.isAnimating
          ? "Pause"
          : "Start",
      color: counterProvider.isPlaying &&
              counterProvider.animationController.isAnimating
          ? orange
          : green,
      borderColor: counterProvider.isPlaying &&
              counterProvider.animationController.isAnimating
          ? orange
          : green,
      textColor: counterProvider.isPlaying &&
              counterProvider.animationController.isAnimating
          ? orange
          : green,
    );
  }

  _cancelButton(CounterProvider counterProvider) {
    return CircleButton(
      onTap: () {
        counterProvider.cancelCounter();
      },
      opacity: counterProvider.animationController.value == 0 ? 0.4 : 1,
      borderColor: Theme.of(context).primaryColor,
      color: Theme.of(context).primaryColor,
      textColor: Theme.of(context).primaryColor,
      text: "Cancel",
    );
  }

  _counterClock(CounterProvider counterProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 100),
        SizedBox(
          height: 300,
          width: 300,
          child: Stack(
            fit: StackFit.expand,
            children: [
              CircularProgressIndicator(
                value: counterProvider.animationController.value,
                color: orange,
                backgroundColor: Colors.transparent,
              ),
              Center(
                child: Text(
                  counterProvider.counterText,
                  style: Theme.of(context)
                      .textTheme
                      .headline2!
                      .copyWith(color: Theme.of(context).primaryColor),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  _durationPicker(CounterProvider counterProvider) {
    return Column(
      children: [
        const SizedBox(height: 150),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TimePickerItem(
              onAdd: () => counterProvider.addHours(),
              onMinus: () => counterProvider.substructHours(),
              unit: "h",
              value: counterProvider.choosedDuration['h']!,
            ),
            const SizedBox(width: 15),
            TimePickerItem(
              onAdd: () => counterProvider.addMinutes(),
              onMinus: () => counterProvider.substructMinutes(),
              unit: "min",
              value: counterProvider.choosedDuration['m']!,
            ),
            const SizedBox(width: 15),
            TimePickerItem(
              onAdd: () => counterProvider.addSeconds(),
              onMinus: () => counterProvider.substructSeconds(),
              unit: "s",
              value: counterProvider.choosedDuration['s']!,
            ),
          ],
        ),
      ],
    );
  }
}
