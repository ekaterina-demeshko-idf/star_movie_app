import 'package:presentation/screen/splash/splash_screen.dart';

import '../../navigation/base_page.dart';

class AppData {
  final List<BasePage> pages;
  bool hideNavBar;

  AppData(
    this.pages,
    this.hideNavBar,
  );

  factory AppData.init() {
    final pages = List<BasePage>.from(
      [SplashScreen.page()],
    );

    return AppData(
      pages,
      false,
    );
  }
}
