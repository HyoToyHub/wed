import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:ui';

class ImageUtils {
  static String currentBackground =
      'assets/images/background/background-01.jpeg';
  static String nextBackground = 'assets/images/background/background-02.jpeg';

  static Future<void> loadLastSelectedImage(Function updateState) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstImageShown = prefs.getBool('isFirstImageShown') ?? true;
    String loadedCurrentBackground =
        prefs.getString('currentBackground') ?? currentBackground;
    String loadedNextBackground =
        prefs.getString('nextBackground') ?? nextBackground;

    updateState(
        isFirstImageShown, loadedCurrentBackground, loadedNextBackground);
  }

  static Future<void> saveLastSelectedImage(bool isFirstImageShown) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirstImageShown', isFirstImageShown);
    await prefs.setString('currentBackground',
        isFirstImageShown ? currentBackground : nextBackground);
    await prefs.setString('nextBackground',
        isFirstImageShown ? nextBackground : currentBackground);
  }

  static Widget buildAnimatedBackground(Animation<double> opacityAnimation) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(currentBackground,
            fit: BoxFit.cover, key: Key(currentBackground)),
        FadeTransition(
          opacity: opacityAnimation,
          child: Image.asset(nextBackground,
              fit: BoxFit.cover, key: Key(nextBackground)),
        ),
        _buildBlurredOverlay(),
      ],
    );
  }

  // 블러 효과를 적용하는 위젯을 생성합니다.
  static Widget _buildBlurredOverlay() {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
      child: Container(color: Colors.black.withOpacity(0.0)),
    );
  }
}
