import 'dart:math';

class Wind {
  Wind._();
  static Wind instance = Wind._();
  final random = Random();
  double xVelocity = 0;
  int yVelocity = 0;

  /// 風が吹くタイミングを決定する
  int time = 0;

  /// 風向きを変える
  void changeWindow() {
    xVelocity = xVelocity + (random.nextDouble() - .5) / 10;
    yVelocity = random.nextInt(5);
  }

  Future<void> mainLoop() async {
    int count = 0;
    time = random.nextInt(500);
    while (true) {
      await Future.delayed(const Duration(milliseconds: 100));
      count++;
      changeWindow();
      if (count > time) {
        count = 0;
        time = random.nextInt(500);
        xVelocity = xVelocity + (random.nextDouble() - .5);
      }
    }
  }
}
