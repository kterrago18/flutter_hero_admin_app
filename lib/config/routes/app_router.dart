import 'package:flutter/material.dart';
import 'package:flutter_hero_admin_app/ui/views/views.dart';
import 'package:flutter_hero_admin_app/viewmodels/viewmodels.dart';
import '../../models/models.dart';

// 1
class AppRouter extends RouterDelegate
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  @override
  final GlobalKey<NavigatorState> navigatorKey;

  final AppStateManager appStateManager;
  final LoginStateManager loginStateManager;
  // final GroceryManager groceryManager;
  final ProfileViewmodel profileViewmodel;

  AppRouter({
    required this.appStateManager,
    required this.loginStateManager,
    // required this.groceryManager,
    required this.profileViewmodel,
  }) : navigatorKey = GlobalKey<NavigatorState>() {
    appStateManager.addListener(notifyListeners);
    loginStateManager.addListener(notifyListeners);
    // groceryManager.addListener(notifyListeners);
    profileViewmodel.addListener(notifyListeners);
  }

  @override
  void dispose() {
    appStateManager.removeListener(notifyListeners);
    loginStateManager.removeListener(notifyListeners);
    // groceryManager.removeListener(notifyListeners);
    profileViewmodel.removeListener(notifyListeners);
    super.dispose();
  }

  // 5
  @override
  Widget build(BuildContext context) {
    // 6
    return Navigator(
      // 7
      key: navigatorKey,
      onPopPage: _handlePopPage,
      // 8
      pages: [
        if (!appStateManager.isInitialized) SplashView.page(),
        if (appStateManager.isInitialized && !appStateManager.isLoggedIn)
          LoginView.page(),
        // if (appStateManager.isLoggedIn && !appStateManager.isOnboardingComplete)
        //   OnboardingScreen.page(),
        if (appStateManager.isLoggedIn)
          HomeView.page(
              currentTab: appStateManager.getSelectedTab,
              titleBar: appStateManager.titleBarStr),
        // if (appStateManager.isOnboardingComplete)
        //   Home.page(appStateManager.getSelectedTab),
        // if (groceryManager.isCreatingNewItem)
        //   GroceryItemScreen.page(onCreate: (item) {
        //     groceryManager.addItem(item);
        //   }, onUpdate: (item, index) {
        //     // No update
        //   }),
        // // 1
        // if (groceryManager.selectedIndex != -1)
        //   // 2
        //   GroceryItemScreen.page(
        //       item: groceryManager.selectedGroceryItem,
        //       index: groceryManager.selectedIndex,
        //       onUpdate: (item, index) {
        //         // 3
        //         groceryManager.updateItem(item, index);
        //       },
        //       onCreate: (_) {
        //         // No create
        //       }),
        // if (profileManager.didSelectUser)
        //   ProfileScreen.page(profileManager.getUser),
        // if (loginStateManager.didCreateAccountSelected)
        //   CreateAccountScreen.page(),
        if (loginStateManager.didForgotPasswordSelected)
          ForgotPasswordView.page(),
        // if (profileManager.didTapOnRaywenderlich) WebViewScreen.page()
      ],
    );
  }

  bool _handlePopPage(
      // 1
      Route<dynamic> route,
      // 2
      result) {
    // 3
    if (!route.didPop(result)) {
      // 4
      return false;
    }

    // // 5
    // if (route.settings.name == FooderlichPages.onboardingPath) {
    //   appStateManager.logout();
    // }
    // if (route.settings.name == FooderlichPages.groceryItemDetails) {
    //   groceryManager.groceryItemTapped(-1);
    // }

    if (route.settings.name == HeroAdminPages.profilePath) {
      profileViewmodel.tapOnProfile(false);
    }

    // if (route.settings.name == HeroAdminPages.createAccountPath) {
    //   loginStateManager.tapOnCreateAccount(false);
    // }

    if (route.settings.name == HeroAdminPages.forgotPasswordPath) {
      loginStateManager.tapOnForgotPassword(false);
    }

    // if (route.settings.name == FooderlichPages.raywenderlich) {
    //   profileManager.tapOnRaywenderlich(false);
    // }
    return true;
  }

  // 9
  @override
  Future<void> setNewRoutePath(configuration) async => null;
}
