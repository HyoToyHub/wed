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

class _MyHomePageState extends State<MyHomePage> {
  // 기준 날짜 설정
  static final DateTime anniversary = DateTime(2023, 4, 25);

  // 날짜 차이 계산
  // static final int daysDifference = today.difference(anniversary).inDays;

  int dDayText = -1;

  @override
  void initState() {
    super.initState();
    updateDDay();
  }

  void updateDDay() {
    final now = DateTime.now();
    setState(() {
      dDayText = now.difference(anniversary).inDays + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(fit: StackFit.expand, children: <Widget>[
        Image.asset(
          'assets/images/background-01.jpeg',
          fit: BoxFit.cover,
        ),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0), // 블러 강도 조절
          child: Container(
            color: Colors.black.withOpacity(0.0), // 배경 색 투명도 조정
          ),
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                '우리가 함께한 지',
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.white,
                  fontFamily: 'jalnan', // 폰트 적용
                ),
              ),
              const SizedBox(height: 10), // 공간 추가
              Text(
                '$dDayText일',
                style: const TextStyle(
                  fontSize: 50,
                  color: Colors.white,
                  fontFamily: 'jalnan', // 폰트 적용
                ),
              ),
              const SizedBox(height: 5),
              Text(
                '${anniversary.year}.${anniversary.month.toString().padLeft(2, '0')}.${anniversary.day.toString().padLeft(2, '0')}.',
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontFamily: 'Ultra', // 폰트 적용
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
