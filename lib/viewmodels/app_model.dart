import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hero_admin_app/services/authentication_service.dart';

class HeroClientTab {
  static const int tasks = 0;
  static const int services = 1;
  static const int bookings = 2;
  static const int reports = 3;
  static const int chats = 4;
  static const List<String> tabsTitle = [
    'Tasks',
    'Services',
    'Bookings',
    'Reports',
    'Chats'
  ];
}

enum AppState { idle, busy }

class AppsModel extends ChangeNotifier {
  bool _initialized = false;
  bool _isEmailExist = false;
  bool _isAuthorized = false;
  bool _loggedIn = false;
  bool _onboardingComplete = false;
  bool _isSignedUp = false;
  late AppState _appState;

  int _selectedTab = HeroClientTab.tasks;
  String _titleBarStr = HeroClientTab.tabsTitle.elementAt(HeroClientTab.tasks);
  final AuthenticationService _authenticationService = AuthenticationService();

  bool get isInitialized => _initialized;
  bool get isLoggedIn => _loggedIn;
  bool get isSignedUp => _isSignedUp;
  bool get isEmailExist => _isEmailExist;
  bool get isAuthorized => _isAuthorized;
  bool get isOnboardingComplete => _onboardingComplete;
  int get getSelectedTab => _selectedTab;
  String get titleBarStr => _titleBarStr;
  AppState get appState => _appState;

  void setTitleBarStr(int selectedTabIndex) {
    _titleBarStr = HeroClientTab.tabsTitle.elementAt(selectedTabIndex);
    notifyListeners();
  }

  void initializeApp() {
    // 7
    Timer(
      const Duration(milliseconds: 2000),
      () {
        // 8
        _initialized = true;
        _appState = AppState.idle;
        // 9
        notifyListeners();
      },
    );
  }

  Future<void> login(String email, String password) async {
    _appState = AppState.busy;
    try {
      await _authenticationService.login(email: email, password: password);
      //_isEmailExist = true;
      _isAuthorized = true;
      _loggedIn = true;
    } on CustomException catch (e) {
      _loggedIn = false;
      _isAuthorized = false;
      if (kDebugMode) {
        print(e.cause);
      }
    }

    _appState = AppState.idle;

    // if (email == 'sample@gmail.com') {
    //   _isEmailExist = true;
    // } else {
    //   _isEmailExist = false;
    // }

    // if (email == 'sample@gmail.com' && password == 'samplepassword') {
    //   _isEmailExist = true;
    //   _isAuthorized = true;
    //   _loggedIn = true;
    // }

    notifyListeners();
  }

  Future<void> signUp(String email, String password) async {
    try {
      await _authenticationService.signUp(email: email, password: password);
      _isSignedUp = true;
    } on CustomException catch (e) {
      _isSignedUp = false;
      if (kDebugMode) {
        print('## sign up error: $e');
      }
    }
    // if (email == 'sample@gmail.com') {
    //   _isEmailExist = true;
    // } else {
    //   _isEmailExist = false;
    // }

    // if (email == 'sample@gmail.com' && password == 'samplepassword') {
    //   _isEmailExist = true;
    //   _isAuthorized = true;
    //   _loggedIn = true;
    // }

    notifyListeners();
  }

  void completeOnboarding() {
    _onboardingComplete = true;
    notifyListeners();
  }

  void goToTab(index) {
    _selectedTab = index;
    notifyListeners();
  }

  void goToBookings() {
    _selectedTab = HeroClientTab.bookings;
    notifyListeners();
  }

  void logout() {
    _loggedIn = false;
    _onboardingComplete = false;
    _initialized = false;
    _selectedTab = 0;
    _isAuthorized = false;
    _isEmailExist = false;

    initializeApp();

    notifyListeners();
  }
}
