import 'dart:async';

import 'package:core_erp/controllers/main_controller.dart';

class ComingSoonController extends MainController {
  Timer? countdownTimer;
  Duration myDuration = Duration(days: 15);

  void startTimer() {
    countdownTimer =
        Timer.periodic(Duration(seconds: 1), (_) => setCountDown());
    update();
  }

  void setCountDown() {
    final reduceSecondsBy = 1;

    final seconds = myDuration.inSeconds - reduceSecondsBy;
    if (seconds < 0) {
      countdownTimer!.cancel();
    } else {
      myDuration = Duration(seconds: seconds);
    }
    update();
  }

  @override
  onInit() async {
    super.onInit();
    startTimer();
  }

  @override
  String getTag() {
    return "coming_soon_controller";
  }
}
