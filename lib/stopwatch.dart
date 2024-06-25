import 'dart:async';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:clickclock/blocky_number.dart';

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

  List<Widget> generateClockOptions(
    int numberOfOptions,
    double size,
    Color selectedColor,
    Color unselectedColor,
    String selection,
  ) {
    final int selectedIndex;
    if (selection == "hours") {
      selectedIndex = hours;
    } else if (selection == "minutes") {
      selectedIndex = minutes;
    } else {
      selectedIndex = seconds;
    }

    return [
      for (var i = 0; i < numberOfOptions; i++)
        BlockyNumber(
          number: i.toString().padLeft(2, "0"),
          size: size,
          color: i == selectedIndex ? selectedColor : unselectedColor,
        ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final clockStyle = theme.textTheme.displayLarge!;
    final clockColor1 = theme.colorScheme.secondary;
    final clockColor2 = theme.colorScheme.primary;
    final clockColor3 = theme.colorScheme.secondaryFixedDim;
    final unselectedColor = theme.colorScheme.surfaceContainerHighest;

    final List<Widget> clock;
    if (isRunning) {
      clock = [
        BlockyNumber(
          number: hours.toString().padLeft(2, "0"),
          size: clockStyle.fontSize!,
          color: clockColor1,
        ),
        SizedBox(
          height: clockStyle.fontSize! / 2,
        ),
        BlockyNumber(
          number: minutes.toString().padLeft(2, "0"),
          size: clockStyle.fontSize!,
          color: clockColor2,
        ),
        SizedBox(
          height: clockStyle.fontSize! / 2,
        ),
        BlockyNumber(
          number: seconds.toString().padLeft(2, "0"),
          size: clockStyle.fontSize!,
          color: clockColor3,
        ),
      ];
    } else {
      clock = [
        CarouselSlider(
          items: generateClockOptions(
            24,
            clockStyle.fontSize!,
            clockColor1,
            unselectedColor,
            "hours",
          ),
          options: CarouselOptions(
            enlargeCenterPage: true,
            enlargeStrategy: CenterPageEnlargeStrategy.zoom,
            enlargeFactor: 0.4,
            viewportFraction: 0.3,
            height: clockStyle.fontSize! * 1.5,
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
          items: generateClockOptions(
            60,
            clockStyle.fontSize!,
            clockColor2,
            unselectedColor,
            "minutes",
          ),
          options: CarouselOptions(
            enlargeCenterPage: true,
            enlargeStrategy: CenterPageEnlargeStrategy.zoom,
            enlargeFactor: 0.4,
            viewportFraction: 0.3,
            height: clockStyle.fontSize! * 1.5,
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
          items: generateClockOptions(
            60,
            clockStyle.fontSize!,
            clockColor3,
            unselectedColor,
            "seconds",
          ),
          options: CarouselOptions(
            enlargeCenterPage: true,
            enlargeStrategy: CenterPageEnlargeStrategy.zoom,
            enlargeFactor: 0.4,
            viewportFraction: 0.3,
            height: clockStyle.fontSize! * 1.5,
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
