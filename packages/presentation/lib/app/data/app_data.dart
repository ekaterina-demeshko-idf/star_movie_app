import 'package:presentation/screen/splash/splash_screen.dart';

import '../../navigation/base_page.dart';

class AppData {
  final List<BasePage> pages;

  AppData(
    this.pages,
  );

  factory AppData.init() {
    final pages = List<BasePage>.from([SplashScreen.page()]);
    return AppData(pages);
  }
}
