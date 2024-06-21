import 'package:flutter/material.dart';
import 'package:clickclock/home.dart';
import 'package:clickclock/timer.dart';
import 'package:clickclock/stopwatch.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Click Clock',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedPage = 1;

  @override
  Widget build(BuildContext context) {
    final Widget currentPage;
    switch (selectedPage) {
      case 0:
        currentPage = const Timer();
        break;

      case 1:
        currentPage = const Home();
        break;

      case 2:
        currentPage = const Stopwatch();
        break;

      default:
        currentPage = const Home();
    }

    return Scaffold(
      body: currentPage,
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedPage,
        onDestinationSelected: (value) {
          setState(() {
            selectedPage = value;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.timer),
            label: "Chronomètre",
          ),
          NavigationDestination(
            icon: Icon(Icons.home),
            label: "Accueil",
          ),
          NavigationDestination(
            icon: Icon(Icons.hourglass_top),
            label: "Minuteur",
          ),
        ],
      ),
    );
  }
}
