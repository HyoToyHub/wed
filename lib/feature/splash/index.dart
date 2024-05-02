import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:weday/gen/assets.gen.dart';
import 'package:weday/gen/colors.gen.dart';
import 'package:weday/widget/app_text.dart';

import '../../config/route/route.dart';

/**
 * 앱이 실행 될 때 노출되는 Splash 화면
 */
class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}


class _SplashViewState extends State<SplashView> {

  /// 로그인 구현 되면 로직 변경
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 2), () {
      GoRouter.of(context).pushReplacementNamed(ViewRoute.home.name);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Assets.icons.tempBgJiwon.image(),
          ),
          const Positioned(
            right: 0,
            left: 0,
            bottom: 62,
            child: AppText(
              "Copyright 2024. hyo_taes all rights reserved.",
              style: TypoStyle.bodySmall,
              color: ColorName.gray700,
              textAlign: TextAlign.center,
              maxLines: 1,
            ),
          )
        ],
      ),
    );
  }
}