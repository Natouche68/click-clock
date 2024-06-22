import 'dart:async';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Stopwatch extends StatefulWidget {
  const Stopwatch({super.key});

  @override
  State<Stopwatch> createState() => _StopwatchState();
}

class _StopwatchState extends State<Stopwatch> {
  Timer? timer;
  int time = 300;
  int initialTime = 0;
  bool isRunning = false;
  bool isPaused = false;
  int hours = 0;
  int minutes = 0;
  int seconds = 0;

  @override
  void initState() {
    super.initState();
    updateTimeParts(time);

    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      if (isRunning && !isPaused) {
        setState(() {
          time -= 1;

          if (time < 0) {
            isRunning = false;
            isPaused = false;
            time = initialTime;
          }

          updateTimeParts(time);
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();

    if (timer!.isActive) {
      timer!.cancel();
    }
  }

  void _onStartButtonPressed() {
    setState(() {
      isRunning = true;
      initialTime = time;
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

  void _onStopButtonPressed() {
    setState(() {
      isRunning = false;
      isPaused = false;
      time = initialTime;
      updateTimeParts(time);
    });
  }

  void updateTime() {
    setState(() {
      time = hours * 3600 + minutes * 60 + seconds;
    });
    updateTimeParts(time);
  }

  void updateTimeParts(int time) {
    setState(() {
      hours = (time / 3600).floor();
      minutes = ((time - hours * 3600) / 60).floor();
      seconds = time - hours * 3600 - minutes * 60;
    });
  }

  List<Widget> generateClockOptions(int numberOfOptions, TextStyle? style) {
    return [
      for (var i = 0; i < numberOfOptions; i++)
        Text(
          i.toString().padLeft(2, "0"),
          style: style,
        ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final clockStyle = theme.textTheme.displayLarge;

    final List<Widget> clock;
    if (isRunning) {
      clock = [
        Text(
          hours.toString().padLeft(2, "0"),
          style: clockStyle,
        ),
        Text(
          minutes.toString().padLeft(2, "0"),
          style: clockStyle,
        ),
        Text(
          seconds.toString().padLeft(2, "0"),
          style: clockStyle,
        ),
      ];
    } else {
      clock = [
        CarouselSlider(
          items: generateClockOptions(24, clockStyle),
          options: CarouselOptions(
            enlargeCenterPage: true,
            enlargeStrategy: CenterPageEnlargeStrategy.zoom,
            viewportFraction: 0.3,
            height: (clockStyle?.fontSize ?? 32) + 4,
            initialPage: hours,
            onPageChanged: (index, reason) {
              setState(() {
                hours = index;
                updateTime();
              });
            },
          ),
        ),
        CarouselSlider(
          items: generateClockOptions(60, clockStyle),
          options: CarouselOptions(
            enlargeCenterPage: true,
            enlargeStrategy: CenterPageEnlargeStrategy.zoom,
            viewportFraction: 0.3,
            height: (clockStyle?.fontSize ?? 32) + 4,
            initialPage: minutes,
            onPageChanged: (index, reason) {
              setState(() {
                minutes = index;
                updateTime();
              });
            },
          ),
        ),
        CarouselSlider(
          items: generateClockOptions(60, clockStyle),
          options: CarouselOptions(
            enlargeCenterPage: true,
            enlargeStrategy: CenterPageEnlargeStrategy.zoom,
            viewportFraction: 0.3,
            height: (clockStyle?.fontSize ?? 32) + 4,
            initialPage: seconds,
            onPageChanged: (index, reason) {
              setState(() {
                seconds = index;
                updateTime();
              });
            },
          ),
        ),
      ];
    }

    return Column(
      children: [
        Expanded(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: clock,
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
              if (isRunning)
                const SizedBox(
                  width: 8,
                ),
              if (isRunning)
                ElevatedButton.icon(
                  onPressed: _onStopButtonPressed,
                  icon: const Icon(Icons.stop),
                  label: const Text("Arrêter"),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
