import 'dart:async';

class Debounce {
  Duration delay;
  Timer? _timer;
  bool _isFistTime = true;

  Debounce(
    this.delay,
  );

  call(void Function() callback) {
    //Cancel old timer when calling multiple times
    _timer?.cancel();
    //Return callback for the fist time
    if (_isFistTime) {
      _isFistTime = false;
      callback();
      return;
    }
    //create new timer
    _timer = Timer(delay, callback);
  }

  dispose() {
    _timer?.cancel();
  }
}

class CountDownTimer {
  final Duration total;
  final Duration interval;

  final void Function(Duration) onTick;
  final void Function() onFinish;

  Timer? _periodicTimer;
  Timer? _completionTimer;

  CountDownTimer({
    required this.total,
    required this.interval,
    required this.onTick,
    required this.onFinish,
  });

  void start() {
    var endTime = DateTime.now().add(total);
    _periodicTimer = Timer.periodic(interval, (_) {
      var timeLeft = endTime.difference(DateTime.now());
      onTick(timeLeft);
    });
    _completionTimer = Timer(total, () {
      _periodicTimer!.cancel();
      onFinish();
    });
  }

  void cancel() {
    _periodicTimer?.cancel();
    _completionTimer?.cancel();
  }
}
