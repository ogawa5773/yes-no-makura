import 'dart:math';
import 'package:flutter/material.dart';
import '../models/wind.dart';

class RainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: Stack(
        children: [
          ...List.generate(
            2000, // 雨粒の数
            (_) => Particle(
              key: UniqueKey(),
              rainArea: 5000,
            ),
          )
        ],
      ),
    );
  }
}

class Particle extends StatefulWidget {
  Particle({required Key key, required this.rainArea}) : super(key: key);
  final double rainArea;

  @override
  _ParticleState createState() => _ParticleState();
}

class _ParticleState extends State<Particle>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController = AnimationController(
    vsync: this,
    // 経過時間変えてもアニメーション変化ないぞ？
    duration: const Duration(seconds: 1),
  );
  final random = Random();
  late double initXPos;
  late double initYPos;
  late double strokeWidth;
  late double length;
  late double resetTime;

  int count = 0;
  @override
  void initState() {
    super.initState();
    reset();
    animationController.addListener(() {
      count++;
      if (count > resetTime) {
        reset();
      }
    });
    animationController.repeat();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void reset() {
    count = 0;
    // ここでrandom.nextDouble()を用いて位置と粒度がランダムな雨粒を生成している
    //// -500 <= x <= 1500 ??
    initXPos = (random.nextDouble() * widget.rainArea) - (widget.rainArea / 2);
    initYPos = -random.nextDouble() * 1000;
    strokeWidth = random.nextDouble();
    length = random.nextDouble() * 10;
    //// 10 <= x <= 110 ??
    resetTime = 10 + random.nextDouble() * 100;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) {
        return CustomPaint(
          // 1秒ごとに位置が変化する（count × velocity分位置が変化する
          painter: ParticlePainter(
            // x軸でWind.instance.yVelocity + 60.0をかけるのはなぜ？
            xPos: initXPos +
                (count *
                    (Wind.instance.xVelocity *
                        (Wind.instance.yVelocity + 60.0))),
            yPos: initYPos + (count * (Wind.instance.yVelocity + 60.0)),
            strokeWidth: strokeWidth,
            length: length,
            xVelocity: Wind.instance.xVelocity,
          ),
        );
      },
    );
  }
}

// 与えられた条件で描画してるだけ
class ParticlePainter extends CustomPainter {
  ParticlePainter({
    required this.xPos,
    required this.yPos,
    required this.strokeWidth,
    required this.length,
    required this.xVelocity,
  });

  final double xPos;
  final double yPos;
  final double strokeWidth;
  final double length;
  final double xVelocity;

  @override
  // size=画面サイズ, canvas=それに乗っけるcanvas？
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    final random = Random();
    // 0 <= x <= 0.02
    final fluctuation = random.nextDouble() / 50;
    paint.strokeWidth = strokeWidth;
    paint.color = Colors.blueGrey;
    canvas.drawLine(
      Offset(xPos, yPos),
      Offset(
        xPos + (40 + length) * (xVelocity + fluctuation),
        yPos + (40 + length),
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
