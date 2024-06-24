import 'dart:async';
import 'package:flutter/material.dart';
import 'package:clickclock/blocky_number.dart';

class TimerPage extends StatefulWidget {
  const TimerPage({super.key});

  @override
  State<TimerPage> createState() => _TimerState();
}

class _TimerState extends State<TimerPage> {
  Timer? timer;
  double time = 0;
  bool isRunning = false;
  bool isPaused = false;

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(
      const Duration(milliseconds: 10),
      (Timer t) {
        setState(() {
          if (isRunning && !isPaused) {
            time += 0.01;
          }
        });
      },
    );
  }

  @override
  void dispose() {
    super.dispose();

    if (timer != null) {
      if (timer!.isActive) {
        timer!.cancel();
      }
    }
  }

  void _onStartButtonPressed() {
    setState(() {
      isRunning = true;
    });
  }

  void _onPauseButtonPressed() {
    setState(() {
      isPaused = true;
    });
  }

  void _onResumeButtonPressed() {
    setState(() {
      isPaused = false;
    });
  }

  void _onResetButtonPressed() {
    setState(() {
      isRunning = false;
      isPaused = false;
      time = 0;
    });
  }

  Map<String, int> getTimeParts(double time) {
    final int numberOfSeconds = time.floor();
    final int secondFractions =
        ((time / 0.01).floor() - numberOfSeconds * 100).toInt();
    final int minutes = (numberOfSeconds / 60).floor();
    final int seconds = numberOfSeconds - minutes * 60;

    return {
      "minutes": minutes,
      "seconds": seconds,
      "secondFractions": secondFractions,
    };
  }

  @override
  Widget build(BuildContext context) {
    final timeParts = getTimeParts(time);

    final theme = Theme.of(context);
    final clockStyle = theme.textTheme.displayLarge!;

    return Column(
      children: [
        Expanded(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                BlockyNumber(
                  number: timeParts["minutes"].toString().padLeft(2, "0"),
                  size: clockStyle.fontSize!,
                  color: clockStyle.color!,
                ),
                SizedBox(
                  height: clockStyle.fontSize! / 2,
                ),
                BlockyNumber(
                  number: timeParts["seconds"].toString().padLeft(2, "0"),
                  size: clockStyle.fontSize!,
                  color: clockStyle.color!,
                ),
                SizedBox(
                  height: clockStyle.fontSize! / 2,
                ),
                BlockyNumber(
                  number:
                      timeParts["secondFractions"].toString().padLeft(2, "0"),
                  size: clockStyle.fontSize!,
                  color: clockStyle.color!,
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (!isRunning)
                ElevatedButton.icon(
                  onPressed: _onStartButtonPressed,
                  icon: const Icon(Icons.play_arrow),
                  label: const Text("Démarrer"),
                ),
              if (isRunning && !isPaused)
                ElevatedButton.icon(
                  onPressed: _onPauseButtonPressed,
                  icon: const Icon(Icons.pause),
                  label: const Text("Pause"),
                ),
              if (isRunning && isPaused)
                ElevatedButton.icon(
                  onPressed: _onResumeButtonPressed,
                  icon: const Icon(Icons.play_arrow),
                  label: const Text("Continuer"),
                ),
              if (isRunning && isPaused)
                const SizedBox(
                  width: 8,
                ),
              if (isRunning && isPaused)
                ElevatedButton.icon(
                  onPressed: _onResetButtonPressed,
                  icon: const Icon(Icons.stop),
                  label: const Text("Remettre à zéro"),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
