import 'package:counter_app/screens/home.dart';
import 'package:counter_app/screens/my_app.dart';
import 'package:counter_app/services/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// void main() {
//   return runApp(ChangeNotifierProvider<ThemeNotifier>(
//     create: (_) => ThemeNotifier(),
//     child: const MyApp(),
//   ));
// }

void main() {
  return runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeNotifier>(create: (ctx) => ThemeNotifier()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(builder: (context, themeNotifier, child) {
      return MaterialApp(
        title: "Countdown app",
        debugShowCheckedModeBanner: false,
        scrollBehavior: const MaterialScrollBehavior(),
        theme: themeNotifier.getTheme,
        home: const Home(),
      );
    });
  }
}
