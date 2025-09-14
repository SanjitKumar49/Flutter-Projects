import 'package:get/get.dart';
import 'package:super_app_ml_kit/app/controllers/scenesense_controller.dart';
import 'package:super_app_ml_kit/app/screen/home_screen.dart';
import 'package:super_app_ml_kit/app/screen/scenesense_screen.dart';
import 'package:super_app_ml_kit/app/screen/sing_in.dart';
import 'package:super_app_ml_kit/app/screen/sing_up.dart';
import 'package:super_app_ml_kit/app/screen/splash_screen.dart';
import 'package:super_app_ml_kit/app/screen/textsnap_screen.dart';
import 'package:super_app_ml_kit/app/screen/trackit_screen.dart';
import '../bindings/textsnap_binding.dart';
import '../bindings/scenesense_binding.dart';
import '../bindings/trackit_binding.dart';


class AppPages {
  static final pages = [
    GetPage(name: Routes.SPLASH, page: () => SplashScreen()),
    GetPage(name: Routes.SIGNIN, page: () => SignInScreen()),
    GetPage(name: Routes.SIGNUP, page: () => SignUpScreen()),
    GetPage(name: Routes.HOME, page: () => HomeScreen()),
    GetPage(name: Routes.TEXTSNAP, page: () => TextsnapScreen(), binding: TextSnapBinding()),
    GetPage(name: Routes.SCENESENSE, page: () => ScenesenseScreen(), binding: ScenesenseBinding()),
   GetPage(name: Routes.TRACKIT, page: () => TrackitScreen(), binding: TrackitBinding()),
  ];
}


abstract class Routes {
  static const SPLASH = '/';
  static const SIGNIN = '/signin';
  static const SIGNUP = '/signup';
  static const HOME = '/home';
  static const TEXTSNAP = '/textsnap';
  static const SCENESENSE = '/scenesense';
  static const TRACKIT = '/trackit';
}

