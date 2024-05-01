import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:shared_preferences/shared_preferences.dart';

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
  // 날짜 계산을 위한 기념일 설정
  static final DateTime anniversary = DateTime(2023, 4, 25);
  int dDayText = -1;

  // 이미지 경로 설정
  bool _isFirstImageShown = true;
  String _currentBackground = 'assets/images/background/background-01.jpeg';
  String _nextBackground = 'assets/images/background/background-02.jpeg';

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

    _loadLastSelectedImage();
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
    _saveLastSelectedImage(); // Save last selected image
  }

  Future<void> _loadLastSelectedImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isFirstImageShown = prefs.getBool('isFirstImageShown') ?? true;

    setState(() {
      _isFirstImageShown = prefs.getBool('isFirstImageShown') ?? true;
      _currentBackground =
          prefs.getString('currentBackground') ?? _currentBackground;
      _nextBackground = prefs.getString('nextBackground') ?? _nextBackground;
    });
  }

  Future<void> _saveLastSelectedImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirstImageShown', _isFirstImageShown);

    if (_isFirstImageShown) {
      await prefs.setString('currentBackground', _currentBackground);
      await prefs.setString('nextBackground', _nextBackground);
    } else {
      await prefs.setString('currentBackground', _nextBackground);
      await prefs.setString('nextBackground', _currentBackground);
    }
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
        child: _buildAnimatedBackground(),
      ),
    );
  }

  Widget _buildAnimatedBackground() {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(_currentBackground,
            fit: BoxFit.cover, key: Key(_currentBackground)),
        FadeTransition(
            opacity: _opacityAnimation,
            child: Image.asset(_nextBackground,
                fit: BoxFit.cover, key: Key(_nextBackground))),
        Positioned.fill(child: _buildBlurredOverlay()),
        _buildTextContent(),
      ],
    );
  }

  Widget _buildBlurredOverlay() {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
      child: Container(color: Colors.black.withOpacity(0.0)),
    );
  }

  Widget _buildTextContent() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text('우리가 함께한 지',
              style: TextStyle(
                fontSize: 17,
                color: Colors.white,
                fontFamily: 'jalnan',
              )),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () => _showPast100DayPopup(context), // 지난 100일 이벤트
                child: Image.asset(
                  'assets/images/icon/heart.png',
                  width: 20, // 너비 설정
                  height: 20, // 높이 설정
                ),
              ),
              Text('$dDayText일',
                  style: const TextStyle(
                      fontSize: 50, color: Colors.white, fontFamily: 'jalnan')),
              GestureDetector(
                onTap: () => _showNext100DayPopup(context), // 다음 100일 이벤트
                child: Image.asset(
                  'assets/images/icon/heart.png',
                  width: 20, // 너비 설정
                  height: 20, // 높이 설정
                ),
                // child: const Text('❤️ ',
                //     style: TextStyle(
                //       fontSize: 30,
                //     )),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Text(
              '${anniversary.year}.${anniversary.month.toString().padLeft(2, '0')}.${anniversary.day.toString().padLeft(2, '0')}',
              style: const TextStyle(
                  fontSize: 18, color: Colors.white, fontFamily: 'Ultra')),
        ],
      ),
    );
  }

  Map<String, dynamic> _calculatePast100Day() {
    int daysPast = dDayText % 100;
    DateTime past100Day = anniversary.add(Duration(days: dDayText - daysPast));
    int hundredDayMark = (dDayText - daysPast) ~/ 100 * 100;
    return {
      'past100Day': past100Day,
      'hundredDayMark': hundredDayMark,
    };
  }

  Map<String, dynamic> _calculateNext100Day() {
    int daysUntilNext = 100 - (dDayText % 100);
    DateTime next100Day =
        anniversary.add(Duration(days: dDayText + daysUntilNext));
    int hundredDayMark = (dDayText + daysUntilNext) ~/ 100 * 100;
    return {
      'next100Day': next100Day,
      'hundredDayMark': hundredDayMark,
      'daysUntilNext': daysUntilNext,
    };
  }

  void _showPast100DayPopup(BuildContext context) {
    var calculation = _calculatePast100Day();
    DateTime past100Day = calculation['past100Day'];
    int hundredDayMark = calculation['hundredDayMark'];

    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.4),
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.85),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: const Icon(Icons.close, size: 24),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: const TextStyle(fontFamily: 'Diary', color: Colors.black),
                    children: <TextSpan>[
                      TextSpan(
                        text:
                            "${past100Day.year}.${past100Day.month.toString().padLeft(2, '0')}.${past100Day.day.toString().padLeft(2, '0')}",
                        style: const TextStyle(fontSize: 20),
                      ),
                      TextSpan(
                        text: "\n지난 $hundredDayMark일",
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showNext100DayPopup(BuildContext context) {
    var calculation = _calculateNext100Day();
    DateTime next100Day = calculation['next100Day'];
    int hundredDayMark = calculation['hundredDayMark'];
    int daysUntilNext = calculation['daysUntilNext'];

    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.4),
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.85),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: const Icon(Icons.close, size: 24),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: const TextStyle(fontFamily: 'Diary', color: Colors.black),
                    children: <TextSpan>[
                      TextSpan(
                        text: "다음 $hundredDayMark일까지",
                        style: const TextStyle(fontSize: 20),
                      ),
                      TextSpan(
                        text: "\n$daysUntilNext일 남음",
                        style: const TextStyle(fontSize: 18),
                      ),
                      TextSpan(
                        text:
                            "\n${next100Day.year}.${next100Day.month.toString().padLeft(2, '0')}.${next100Day.day.toString().padLeft(2, '0')}",
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
