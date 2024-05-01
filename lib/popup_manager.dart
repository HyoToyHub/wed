import 'package:flutter/material.dart';
import 'package:weday/date_utils.dart' as my_utils;


class PopupManager {
  static void showPast100DayPopup(BuildContext context, int dDayText) {
    var calculation = my_utils.DateUtils.calculatePast100Day(dDayText);
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

  static void showNext100DayPopup(BuildContext context, int dDayText) {
    var calculation = my_utils.DateUtils.calculateNext100Day(dDayText);
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
