import 'package:flutter/material.dart';

class Palette {
  static const MaterialColor kToDark = MaterialColor(
    0xff111112, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    <int, Color>{
      50: Color(0xff111112), //10%
      100: Color(0xff191A1B), //20%
      200: Color(0xff222324), //30%
      300: Color(0xff434445), //40%
      400: Color(0xff656667), //50%
      500: Color(0xff86878C), //60%
      600: Color(0xffA7A8AC), //70%
      700: Color(0xffC9CACC), //80%
      800: Color(0xffEBEBEC), //90%
      900: Color(0xffF2F2F2), //100%
    },
  );
  static const MaterialColor white = MaterialColor(
    0xffffffff, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    <int, Color>{
      50: Color(0xfff5f5f5), //10%
      100: Color(0xfff0f0f0), //20%
      200: Color(0xffe5e5e5), //30%
      300: Color(0xffE0E0E0), //40%
      400: Color(0xffD5D5D5), //50%
      500: Color(0xffD0D0D0), //60%
      600: Color(0xffC5C5C5), //70%
      700: Color(0xffC0C0C0), //80%
      800: Color(0xffB5B5B5), //90%
      900: Color(0xffB0B0B0), //100%
    },
  );
}
