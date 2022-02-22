import 'dart:async';

import 'package:flutter/material.dart';

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

class AppStateManager extends ChangeNotifier {
  bool _initialized = false;
  bool _isEmailExist = false;
  bool _isAuthorized = false;
  bool _loggedIn = false;

  bool _onboardingComplete = false;

  int _selectedTab = HeroClientTab.tasks;
  String _titleBarStr = HeroClientTab.tabsTitle.elementAt(HeroClientTab.tasks);

  bool get isInitialized => _initialized;
  bool get isLoggedIn => _loggedIn;
  bool get isEmailExist => _isEmailExist;
  bool get isAuthorized => _isAuthorized;
  bool get isOnboardingComplete => _onboardingComplete;
  int get getSelectedTab => _selectedTab;
  String get titleBarStr => _titleBarStr;

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
        // 9
        notifyListeners();
      },
    );
  }

  Future<void> login(String email, String password) async {
    if (email == 'sample@gmail.com') {
      _isEmailExist = true;
    } else {
      _isEmailExist = false;
    }

    if (email == 'sample@gmail.com' && password == 'samplepassword') {
      _isEmailExist = true;
      _isAuthorized = true;
      _loggedIn = true;
    }

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
