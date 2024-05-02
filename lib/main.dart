import 'package:flutter/material.dart';
import 'package:weday/config/route/route.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    ScreenUtilInit(
      designSize: const Size(360, 640),
      builder: (context, child) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'we`d',
          themeMode: ThemeMode.system,
          routerConfig: kRouter,
        );
      },
    ),
  );
}
