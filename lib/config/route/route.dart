import 'package:go_router/go_router.dart';
import 'package:weday/feature/splash/index.dart';
import 'package:weday/feature/home/view/index.dart';

enum ViewRoute {
  splash,
  home
}

extension RouteString on ViewRoute {
  String get name {
    switch (this) {
      case ViewRoute.splash:
        return 'SPLASH';
      case ViewRoute.home:
        return 'HOME';
    }
  }
}


/**
 * route 의 name 을 enum 으로 정의해두고 사용
 * 차후 state 값을 사용하고 진척있을때 ChangeNotifierPovider 사용 예정
 */
final kRouter = GoRouter(
  initialLocation: '/',
  // initialLocation: '/Home',
  observers: [
    // FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance),
  ],
  routes: [
    /// Splash
    GoRoute(
      path: '/',
      name: ViewRoute.splash.name,
      builder: (context, state) {
        return const SplashView();
      },
    ),

    /// Home
    GoRoute(
      path: '/Home',
      name: ViewRoute.home.name,
      builder: (context, state) {
        return const MyHomePage();
      },
    ),
  ]
);