import 'package:domain/usecase/analytics_event_usecase.dart';
import 'package:domain/usecase/analytics_screen_usecase.dart';
import 'package:domain/utils/extensions/string_extension.dart';
import 'package:flutter/widgets.dart';
import 'package:collection/collection.dart';
import 'package:presentation/screen/payment/payment_screen.dart';
import '../base/bloc.dart';
import '../enum/bottom_nav_bar_item.dart';
import '../navigation/base_page.dart';
import '../screen/home/home_screen.dart';
import '../screen/login/login_screen.dart';
import 'data/app_data.dart';

abstract class AppBloc extends Bloc {
  factory AppBloc(
    LogAnalyticsEventUseCase logAnalyticsEventUseCase,
    LogAnalyticsScreenUseCase logAnalyticsScreenUseCase,
  ) =>
      _AppBloc(
        logAnalyticsEventUseCase,
        logAnalyticsScreenUseCase,
      );

  void handleRemoveRouteSettings(RouteSettings value);

  void onItemTapped(int index);

  int get selectedIndex;
}

class _AppBloc extends BlocImpl implements AppBloc {
  final LogAnalyticsEventUseCase _logAnalyticsEventUseCase;
  final LogAnalyticsScreenUseCase _logAnalyticsScreenUseCase;
  final _appData = AppData.init();
  int _selectedIndex = 0;

  _AppBloc(
    this._logAnalyticsEventUseCase,
    this._logAnalyticsScreenUseCase,
  );

  @override
  int get selectedIndex => _selectedIndex;

  @override
  void initState() {
    super.initState();
    _initNavHandler();
    _updateData();
  }

  @override
  void onItemTapped(int index) {
    _selectedIndex = index;
    final type = BottomNavBarItem.values[index];
    switch (type) {
      case BottomNavBarItem.home:
        _logAnalyticsEventUseCase('home_nav_bar');
        _popAllAndPush(HomeScreen.page(HomeScreenArguments()));
        break;
      case BottomNavBarItem.profile:
        _logAnalyticsEventUseCase('login_nav_bar');
        _popAllAndPush(LoginScreen.page(LoginScreenArguments()));
        break;
      case BottomNavBarItem.ticket:
        _logAnalyticsEventUseCase('ticket_nav_bar');
        _popAllAndPush(PaymentScreen.page());
        break;
      case BottomNavBarItem.notifications:
        // TODO: Handle this case.
        break;
    }
    _updateData();
  }

  @override
  void handleRemoveRouteSettings(RouteSettings value) {
    _appData.pages.remove(value);
    _updateData();
  }

  void _initNavHandler() {
    appNavigator.init(
      push: _push,
      popOldAndPush: _popOldAndPush,
      popAllAndPush: _popAllAndPush,
      popAndPush: _popAndPush,
      pushPages: _pushPages,
      popAllAndPushPages: _popAllAndPushPages,
      pop: _pop,
      maybePop: _maybePop,
      popUntil: _popUntil,
      currentPage: _currentPage,
    );
  }

  void _push(BasePage page) {
    _appData.pages.add(page);
    _updateData();
  }

  void _popAllAndPush(BasePage page) {
    _appData.pages.clear();
    _push(page);
  }

  void _popOldAndPush(BasePage page) {
    final oldIndex = _appData.pages.indexWhere(
      (element) => element.name == page.name,
    );
    if (oldIndex != -1) {
      _appData.pages.removeAt(oldIndex);
    }
    _push(page);
  }

  void _popAndPush(BasePage page) {
    _appData.pages.removeLast();
    _push(page);
    _updateData();
  }

  void _pushPages(List<BasePage> pages) {
    pages.forEach(_appData.pages.add);
    _updateData();
  }

  void _popAllAndPushPages(List<BasePage> pages) {
    _appData.pages.clear();
    pages.forEach(_appData.pages.add);
    _updateData();
  }

  void _pop() {
    _appData.pages.removeLast();
    _updateData();
  }

  void _maybePop() {
    if (_appData.pages.length > 1) {
      _pop();
    }
  }

  void _popUntil(BasePage page) {
    final start = _appData.pages.indexWhere((e) => e.name == page.name) + 1;
    final end = _appData.pages.length;
    _appData.pages.removeRange(start, end);
    _updateData();
  }

  BasePage? _currentPage() => _appData.pages.lastOrNull;

  void _updateData() {
    _appData.hideNavBar = _currentPage()!.hideNavBar;
    if (_currentPage() != null) {
      _logAnalyticsScreenUseCase(_currentPage()!.name.orEmpty);
    }
    super.handleData(data: _appData);
  }
}
