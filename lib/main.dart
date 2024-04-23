import 'package:flutter/material.dart';
import 'dart:ui';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "we'd",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  static final DateTime anniversary = DateTime(2023, 4, 25);
  int dDayText = -1;

  static const String _currentBackground = 'assets/images/background-01.jpeg';
  static const String _nextBackground = 'assets/images/background-02.jpeg';
  bool _isFirstImageShown = true;

  late AnimationController _controller;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    updateDDay();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _opacityAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(_controller)
      ..addListener(() {
        setState(() {}); // Trigger rebuild whenever animation value changes
      });
  }

  void updateDDay() {
    final now = DateTime.now();
    setState(() {
      dDayText = now.difference(anniversary).inDays + 1;
    });
  }

  void toggleBackground() {
    if (_isFirstImageShown) {
      _controller.forward(); // Fade out the first image
    } else {
      _controller.reverse(); // Fade in the first image
    }
    _isFirstImageShown = !_isFirstImageShown;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: toggleBackground,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              _currentBackground,
              fit: BoxFit.cover,
              key: const Key(_currentBackground),
            ),
            FadeTransition(
              opacity: _opacityAnimation,
              child: Image.asset(
                _nextBackground,
                fit: BoxFit.cover,
                key: const Key(_nextBackground),
              ),
            ),
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                child: Container(
                  color: Colors.black.withOpacity(0.0),
                ),
              ),
            ),
            buildTextContent(),
          ],
        ),
      ),
    );
  }

  Widget buildTextContent() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            '우리가 함께한 지',
            style: TextStyle(
              fontSize: 17,
              color: Colors.white,
              fontFamily: 'jalnan',
            ),
          ),
          const SizedBox(height: 10),
          Text(
            '$dDayText일',
            style: const TextStyle(
              fontSize: 50,
              color: Colors.white,
              fontFamily: 'jalnan',
            ),
          ),
          const SizedBox(height: 5),
          Text(
            '${anniversary.year}.${anniversary.month.toString().padLeft(2, '0')}.${anniversary.day.toString().padLeft(2, '0')}',
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontFamily: 'Ultra',
            ),
          ),
        ],
      ),
    );
  }
}
