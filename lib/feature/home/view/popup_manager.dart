import 'package:flutter/material.dart';
import 'package:weday/utils/date/date_utils.dart' as my_utils;
import 'dart:ui'; // ImageFilter를 사용하기 위해 필요합니다.

class PopupManager {
  static void showPast100DayPopup(BuildContext context, int dDayText) {
    var calculation = my_utils.DateUtils.calculatePast100Day(dDayText);
    DateTime past100Day = calculation['past100Day'];
    int hundredDayMark = calculation['hundredDayMark'];

    showDialog(
      context: context,
      barrierColor: Colors.transparent, // 배리어 색상을 완전히 투명하게 설정
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.85),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: const Icon(Icons.close, size: 18),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: const TextStyle(
                        fontFamily: 'Diary', color: Colors.black),
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

  static void showNext100DayPopup(BuildContext context, int dDayText) {
    var calculation = my_utils.DateUtils.calculateNext100Day(dDayText);
    DateTime next100Day = calculation['next100Day'];
    int hundredDayMark = calculation['hundredDayMark'];
    int daysUntilNext = calculation['daysUntilNext'];

    showDialog(
      context: context,
      barrierColor: Colors.transparent, // 배리어 색상을 완전히 투명하게 설정
      builder: (BuildContext context) {
        return Stack(
          children: <Widget>[
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2), // 블러 효과 적용
              child: Container(color: Colors.transparent // 컨테이너에 색상을 지정하지 않음
                  ),
            ),
            Center(
              // 중앙에 위치시킴
              child: Material(
                // Material 위젯 사용
                type: MaterialType.transparency, // Material의 배경을 투명하게
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9, // 화면의 90% 크기
                  height:
                      MediaQuery.of(context).size.height * 0.2, // 화면의 30% 크기
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color:
                        Colors.white.withOpacity(0.5), // 대화상자 내부 흰색 배경 투명도 조절
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    // mainAxisSize: MainAxisSize.min,
                    // mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start, // 중앙 정렬
                    children: <Widget>[
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          icon: const Icon(Icons.close, size: 18),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ),
                      const Spacer(), // 공간 추가
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: const TextStyle(
                              fontFamily: 'Diary', color: Colors.black),
                          children: <TextSpan>[
                            TextSpan(
                              text: "다음 $hundredDayMark일까지",
                              style: const TextStyle(fontSize: 15),
                            ),
                            TextSpan(
                              text: "\n- $daysUntilNext일",
                              style: const TextStyle(fontSize: 50),
                            ),
                            TextSpan(
                              text:
                                  "\n${next100Day.year}.${next100Day.month.toString().padLeft(2, '0')}.${next100Day.day.toString().padLeft(2, '0')}.",
                              style: const TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(), // 공간 추가
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
