class DateUtils {
  static final DateTime anniversary = DateTime(2023, 4, 25);

  static int calculateDDay() {
    final now = DateTime.now();
    return now.difference(anniversary).inDays + 1;
  }

  static Map<String, dynamic> calculatePast100Day(int dDayText) {
    int daysPast = dDayText % 100;
    DateTime past100Day = anniversary.add(Duration(days: dDayText - daysPast));
    int hundredDayMark = (dDayText - daysPast) ~/ 100 * 100;
    return {
      'past100Day': past100Day,
      'hundredDayMark': hundredDayMark,
    };
  }

  static Map<String, dynamic> calculateNext100Day(int dDayText) {
    int daysUntilNext = 100 - (dDayText % 100);
    DateTime next100Day = anniversary.add(Duration(days: dDayText + daysUntilNext));
    int hundredDayMark = (dDayText + daysUntilNext) ~/ 100 * 100;
    return {
      'next100Day': next100Day,
      'hundredDayMark': hundredDayMark,
      'daysUntilNext': daysUntilNext,
    };
  }
}
