import 'dart:async';
import 'package:flutter/material.dart';
import 'package:clickclock/blocky_number.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Timer? timer;
  String hour = DateTime.now().hour.toString();
  String minute = DateTime.now().minute.toString();
  String second = DateTime.now().second.toString();

  @override
  void initState() {
    super.initState();

    _updateTime();
    timer =
        Timer.periodic(const Duration(seconds: 1), (Timer t) => _updateTime());
  }

  @override
  void dispose() {
    super.dispose();

    if (timer!.isActive) {
      timer!.cancel();
    }
  }

  void _updateTime() {
    final DateTime now = DateTime.now();
    setState(() {
      hour = now.hour.toString().padLeft(2, "0");
      minute = now.minute.toString().padLeft(2, "0");
      second = now.second.toString().padLeft(2, "0");
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final clockStyle = theme.textTheme.displayLarge!;
    final clockColor1 = theme.colorScheme.primaryContainer;
    final clockColor2 = theme.colorScheme.primary;
    final clockColor3 = theme.colorScheme.onSurface;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlockyNumber(
            number: hour,
            size: clockStyle.fontSize!,
            color: clockColor1,
          ),
          SizedBox(
            height: clockStyle.fontSize! / 2,
          ),
          BlockyNumber(
            number: minute,
            size: clockStyle.fontSize!,
            color: clockColor2,
          ),
          SizedBox(
            height: clockStyle.fontSize! / 2,
          ),
          BlockyNumber(
            number: second,
            size: clockStyle.fontSize!,
            color: clockColor3,
          ),
        ],
      ),
    );
  }
}
