import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';

class CounterProvider with ChangeNotifier {
  late AnimationController _animationController;
  late TickerProvider _tickerProvider;
  late bool _isPlaying;
  late Map<String, int> _choosedDuration;
  late String _counterText;
  TickerProvider get tickerProvider => _tickerProvider;
  AnimationController get animationController => _animationController;
  bool get isPlaying => _isPlaying;
  Map<String, int> get choosedDuration => _choosedDuration;
  String get counterText => _counterText;

  CounterProvider(TickerProvider tickerProvider) {
    _isPlaying = false;
    _tickerProvider = tickerProvider;
    _animationController = AnimationController(vsync: tickerProvider);
    _counterText = "00:00:00";
    _choosedDuration = {'h': 0, 'm': 0, 's': 0};
  }

  startPauseCounter() {
    if (!_animationController.isAnimating &&
        _choosedDuration != {'h': 0, 'm': 0, 's': 0}) {
      if (_animationController.value == 0) {
        _animationController = _animationController = AnimationController(
          vsync: tickerProvider,
          duration: Duration(
            hours: _choosedDuration['h']!,
            minutes: _choosedDuration['m']!,
            seconds: _choosedDuration['s']!,
          ),
        );
        _animationController.reverse(from: 1);
        _isPlaying = true;
        _animationController.addListener(() {
          Duration count =
              _animationController.duration! * _animationController.value;
          if (_animationController.value == 0) {
            _isPlaying = false;
            _choosedDuration = {'h': 0, 'm': 0, 's': 0};
          }
          _counterText =
              "${count.inHours}:${(count.inMinutes % 60).toString().padLeft(2, '0')}:${(count.inSeconds % 60).toString().padLeft(2, '0')}";
          notifyListeners();
        });
      } else {
        _isPlaying = true;
        _animationController.reverse(from: _animationController.value);
      }
    } else {
      _animationController.stop();
      _isPlaying = false;
    }
    notifyListeners();
  }

  cancelCounter() {
    if (_animationController.value > 0) {
      _animationController.reset();
    }
    _isPlaying = false;
    notifyListeners();
  }

  addHours() {
    if (_choosedDuration['h']! < 23) {
      _choosedDuration['h'] = _choosedDuration['h']! + 1;
    } else {
      _choosedDuration['h'] = 0;
    }
    notifyListeners();
  }

  substructHours() {
    if (_choosedDuration['h']! > 0) {
      _choosedDuration['h'] = _choosedDuration['h']! - 1;
    } else {
      _choosedDuration['h'] = 23;
    }
    notifyListeners();
  }

  addMinutes() {
    if (_choosedDuration['m']! < 59) {
      _choosedDuration['m'] = _choosedDuration['m']! + 1;
    } else {
      _choosedDuration['m'] = 0;
    }
    notifyListeners();
  }

  substructMinutes() {
    if (_choosedDuration['m']! > 0) {
      _choosedDuration['m'] = _choosedDuration['m']! - 1;
    } else {
      _choosedDuration['m'] = 59;
    }
    notifyListeners();
  }

  addSeconds() {
    if (_choosedDuration['s']! < 59) {
      _choosedDuration['s'] = _choosedDuration['s']! + 1;
    } else {
      _choosedDuration['s'] = 0;
    }
    notifyListeners();
  }

  substructSeconds() {
    if (_choosedDuration['s']! > 0) {
      _choosedDuration['s'] = _choosedDuration['s']! - 1;
    } else {
      _choosedDuration['s'] = 59;
    }
    notifyListeners();
  }
}
