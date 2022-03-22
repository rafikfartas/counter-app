import 'dart:developer';

import 'package:counter_app/services/theme_manager.dart';
import 'package:counter_app/theme/colors.dart';
import 'package:counter_app/widgets/time_picker_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with TickerProviderStateMixin {
  late AnimationController _controller;
  bool isPlaying = false;
  int min = 0;
  int sec = 0;
  int hours = 0;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 0),
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String get _counterText {
    Duration count = _controller.duration! * _controller.value;
    if (_controller.value == 0) {
      isPlaying = false;
    }
    return "${count.inHours}:${(count.inMinutes % 60).toString().padLeft(2, '0')}:${(count.inSeconds % 60).toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (ctx, theme, _) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: theme.getTheme,
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Counter app'),
            actions: [
              IconButton(
                onPressed: () {
                  if (theme.getTheme.brightness == Brightness.dark) {
                    theme.setLightMode();
                  } else {
                    theme.setDarkMode();
                  }
                },
                icon: const Icon(Icons.invert_colors_on),
              )
            ],
          ),
          body: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Center(
                  child: Column(
                    children: [
                      _controller.value > 0
                          ? _counterClock(context, theme)
                          : _timePicker(context, theme),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _cancelButton(context, theme),
                            _startButton(context, theme),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }

  _startButton(BuildContext context, ThemeNotifier theme) {
    return Container(
      height: 80,
      width: 80,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.transparent,
        border: Border.all(
          width: 2,
          color: (isPlaying && _controller.isAnimating ? orange : green)
              .withOpacity(0.25),
        ),
      ),
      child: Center(
        child: InkWell(
          onTap: () {
            if (_controller.isAnimating) {
              _controller.stop();
              setState(() {
                isPlaying = false;
              });
            } else {
              if (_controller.value == 0) {
                _controller = AnimationController(
                  vsync: this,
                  duration: Duration(hours: hours, minutes: min, seconds: sec),
                );
              }
              _controller.reverse(
                from: _controller.value == 0 ? 1 : _controller.value,
              );
              setState(() {
                isPlaying = true;
              });
            }
          },
          child: Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: (isPlaying && _controller.isAnimating ? orange : green)
                  .withOpacity(0.25),
            ),
            child: Center(
              child: Text(
                isPlaying && _controller.isAnimating ? "Pause" : "Start",
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                    color:
                        isPlaying && _controller.isAnimating ? orange : green),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _cancelButton(BuildContext context, ThemeNotifier theme) {
    return Opacity(
      opacity: _controller.value == 0 ? 0.4 : 1,
      child: Container(
        height: 80,
        width: 80,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.transparent,
          border: Border.all(
            width: 2,
            color: theme.getTheme.primaryColor.withOpacity(0.2),
          ),
        ),
        child: Center(
          child: InkWell(
            onTap: () {
              if (_controller.value > 0) {
                _controller.reset();
                setState(() {
                  isPlaying = false;
                });
              } else if (_controller.isDismissed) {
                setState(() {
                  isPlaying = false;
                });
              }
            },
            child: Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: theme.getTheme.primaryColor.withOpacity(0.2),
              ),
              child: Center(
                child: Text(
                  "Cancel",
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1!
                      .copyWith(color: theme.getTheme.primaryColor),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _counterClock(BuildContext context, ThemeNotifier theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 100),
        Container(
          height: 300,
          width: 300,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              width: 2,
              color: theme.getTheme.primaryColor,
            ),
          ),
          child: Center(
            child: Text(
              _counterText,
              style: Theme.of(context)
                  .textTheme
                  .headline2!
                  .copyWith(color: theme.getTheme.primaryColor),
            ),
          ),
        ),
      ],
    );
  }

  _timePicker(BuildContext context, ThemeNotifier theme) {
    return StatefulBuilder(builder: (ctx, StateSetter setTime) {
      return Column(
        children: [
          const SizedBox(height: 150),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TimePickerItem(
                theme: theme,
                onAdd: () {
                  if (hours < 23) {
                    setTime(() {
                      hours++;
                    });
                  }
                },
                onMinus: () {
                  if (hours > 0) {
                    setTime(() {
                      hours--;
                    });
                  }
                },
                unit: "h",
                value: hours,
              ),
              const SizedBox(width: 15),
              TimePickerItem(
                theme: theme,
                onAdd: () {
                  if (min < 59) {
                    setTime(() {
                      min++;
                    });
                  }
                },
                onMinus: () {
                  if (min > 0) {
                    setTime(() {
                      min--;
                    });
                  }
                },
                unit: "min",
                value: min,
              ),
              const SizedBox(width: 15),
              TimePickerItem(
                theme: theme,
                onAdd: () {
                  if (sec < 59) {
                    setTime(() {
                      sec++;
                    });
                  }
                },
                onMinus: () {
                  if (sec > 0) {
                    setTime(() {
                      sec--;
                    });
                  }
                },
                unit: "s",
                value: sec,
              ),
            ],
          ),
        ],
      );
    });
  }
}
