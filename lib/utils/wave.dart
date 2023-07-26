import 'package:flutter/material.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';
import 'package:yuk_ngaji/utils/const.dart';

class BackgroundWave extends StatelessWidget {
  const BackgroundWave({super.key});

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: 90,
      child: SizedBox(
        height: double.infinity,
        child: WaveWidget(
          config: CustomConfig(
            colors: const [
              Color(0xFF21497E),
              Color(0xFF2A7FAA),
              Color(0xFF47B9C6),
              Color(0xFFACE9DF),
              Color(0xFFD5F8E2),
            ],
            durations: [32000, 21000, 18000, 5000, 10000],
            heightPercentages: [0.10, 0.20, 0.30, 0.40, 0.50],
          ),
          backgroundColor: newColorFont,
          size: const Size(double.infinity, double.infinity),
          waveAmplitude: 0,
        ),
      ),
    );
  }
}
