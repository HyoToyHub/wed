import 'package:flutter/material.dart';
import 'package:weday/date_utils.dart' as my_utils;
import 'image_utils.dart';
import 'popup_manager.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  bool isFirstImageShown = true;
  String currentBackground = 'assets/images/background/background-01.jpeg';
  String nextBackground = 'assets/images/background/background-02.jpeg';
  int dDayText = 0;

  @override
  void initState() {
    super.initState();
    dDayText = my_utils.DateUtils.calculateDDay();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _opacityAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
    ImageUtils.loadLastSelectedImage(updateState);
  }

  void updateState(bool isFirst, String currentBg, String nextBg) {
    setState(() {
      isFirstImageShown = isFirst;
      currentBackground = currentBg;
      nextBackground = nextBg;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void toggleBackground() {
    if (isFirstImageShown) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
    isFirstImageShown = !isFirstImageShown;
    ImageUtils.saveLastSelectedImage(isFirstImageShown);
  }

  void _showPast100DayPopup(BuildContext context) {
    PopupManager.showPast100DayPopup(context, dDayText);
  }

  void _showNext100DayPopup(BuildContext context) {
    PopupManager.showNext100DayPopup(context, dDayText);
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
                fontFamily: 'Diary',
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
              Text(' $dDayText일 ',
                  style: const TextStyle(
                      fontSize: 50, color: Colors.white, fontFamily: 'Diary')),
              GestureDetector(
                onTap: () => _showNext100DayPopup(context), // 다음 100일 이벤트
                child: Image.asset(
                  'assets/images/icon/heart.png',
                  width: 20, // 너비 설정
                  height: 20, // 높이 설정
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Text(
              '${my_utils.DateUtils.anniversary.year}.${my_utils.DateUtils.anniversary.month.toString().padLeft(2, '0')}.${my_utils.DateUtils.anniversary.day.toString().padLeft(2, '0')}',
              style: const TextStyle(
                  fontSize: 18, color: Colors.white, fontFamily: 'Diary')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GestureDetector(
            onTap: toggleBackground,
            child: ImageUtils.buildAnimatedBackground(_opacityAnimation),
          ),
          _buildTextContent()  // _buildTextContent 호출
        ],
      ),
    );
  }
}
