import 'package:presentation/screen/splash/splash_screen.dart';

import '../../navigation/base_page.dart';

class AppData {
  final List<BasePage> pages;
  final int selectedIndex;
  bool hideNavBar;

  AppData(
    this.pages,
    this.selectedIndex,
    this.hideNavBar,
  );

  factory AppData.init() {
    final pages = List<BasePage>.from(
      [
        SplashScreen.page(),
      ],
    );

    return AppData(
      pages,
      0,
      false,
    );
  }
}
