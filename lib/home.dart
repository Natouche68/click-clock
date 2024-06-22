import 'dart:async';
import 'package:flutter/material.dart';

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
    final clockStyle = theme.textTheme.displayLarge;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            hour,
            style: clockStyle,
          ),
          Text(
            minute,
            style: clockStyle,
          ),
          Text(
            second,
            style: clockStyle,
          ),
        ],
      ),
    );
  }
}
