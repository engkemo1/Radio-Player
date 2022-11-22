import 'dart:async';
import "dart:math" show Random, max, pi;
import 'dart:ui';

import 'package:flutter/material.dart';

import '../../theme.dart';

class Vibes {
  Vibes(this.height, this.color);

  final double height;
  final Color color;

  Vibes get collapsed => Vibes(0.0, color);

  static Vibes lerp(Vibes begin, Vibes end, double t) {
    return Vibes(
      lerpDouble(begin.height, end.height, t)!,
      Color.lerp(Colors.red, Colors.blue, t)!,
    );
  }
}

class Wave {
  Wave(this.wave);

  factory Wave.empty(Size size) {
    return Wave(<Vibes>[]);
  }

  factory Wave.random(Size size, Random random) {
    const waveLenght = 150;

    const color = const Color(0xFF35DEF3);
    final bars = List.generate(
      waveLenght,
          (i) => Vibes(
        random.nextDouble(),
        color,
      ),
    );
    return Wave(bars);
  }

  final List<Vibes> wave;

  static Wave lerp(Wave begin, Wave end, double t) {
    final waveLength = max(begin.wave.length, end.wave.length);
    final waves = List.generate(
      waveLength,
          (i) => Vibes.lerp(
        begin._getWaves(i) ?? end.wave[i].collapsed,
        end._getWaves(i) ?? begin.wave[i].collapsed,
        t,
      ),
    );
    return Wave(waves);
  }

  Vibes? _getWaves(int index) => (index < wave.length ? wave[index] : null);
}

class VibesTween extends Tween<Wave> {
  VibesTween(Wave begin, Wave end) : super(begin: begin, end: end);

  @override
  Wave lerp(double t) => Wave.lerp(begin!, end!, t);
}

class WavesPainter extends CustomPainter {
  WavesPainter(this.animation) : super(repaint: animation);

  final Animation<Wave> animation;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    canvas.translate(size.width / 2, size.height / 2);

    canvas.save();

    final radius = 300 / 2;
    final chart = animation.value;

    for (final wave in chart.wave) {
      paint.color = wave.color;
      canvas.drawLine(
        Offset(0.0, -radius),
        Offset(1.0, -radius - (wave.height * 30)),
        paint,
      );

      canvas.drawRect(
        Rect.fromLTRB(0.00, -radius, 2.00, -radius - (wave.height * 15)),
        paint,
      );
      canvas.rotate(2 * pi / chart.wave.length);
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(WavesPainter old) => true;
}

class Waves extends StatefulWidget {
  final state = WavesState();
  @override
  WavesState createState() => state;

  void changeWaves() {
    state.changeWave();
  }
}

class WavesState extends State<Waves> with TickerProviderStateMixin {
  static const size = Size(100.0, 5.0);
  final random = Random();
  late AnimationController animation;
  late VibesTween tween;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    animation = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    tween = VibesTween(
      Wave.empty(size),
      Wave.random(size, random),
    );
    animation.forward();
    timer = Timer.periodic(const Duration(milliseconds: 500),
            (Timer t) => changeWave()); //speed of the wave
  }

  @override
  void dispose() {
    animation.dispose();
    timer?.cancel();
    super.dispose();
  }

  void changeWave() {
    setState(() {
      tween = VibesTween(
        tween.evaluate(animation),
        Wave.random(size, random),
      );
      animation.forward(from: 0.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400.00,
      height: 400.00,
      padding: const EdgeInsets.all(55.0),
      child: CustomPaint(
        size: size,
        painter: WavesPainter(tween.animate(animation)),
      ),
    );
  }
}
