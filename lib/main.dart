import 'package:flutter/material.dart';
import 'package:flutter_hero_admin_app/viewmodels/viewmodels.dart';
import 'package:provider/provider.dart';

import 'config/routes/app_router.dart';
import 'config/themes/hero_theme.dart';
import 'models/models.dart';

void main() {
  runApp(const HeroAdmin());
}

class HeroAdmin extends StatefulWidget {
  const HeroAdmin({
    Key? key,
  }) : super(key: key);

  @override
  State<HeroAdmin> createState() => _HeroAdminState();
}

class _HeroAdminState extends State<HeroAdmin> {
  final _appStateManager = AppsModel();
  final _createAccountManager = LoginStateManager();
  final _profileViewmodel = ProfileModel();
  late AppRouter _appRouter;

  @override
  void initState() {
    _appRouter = AppRouter(
      appStateManager: _appStateManager,
      loginStateManager: _createAccountManager,
      // groceryManager: _groceryManager,
      profileViewmodel: _profileViewmodel,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => _appStateManager),
        ChangeNotifierProvider(create: (context) => _createAccountManager),
        ChangeNotifierProvider(create: (context) => _profileViewmodel)
      ],
      child: Consumer<ProfileModel>(
        builder: (context, profileViewmodel, child) {
          ThemeData theme = HeroTheme.light();
          // if (profileViewmodel.darkMode) {
          //   theme = HeroTheme.dark();
          // } else {
          //   theme = HeroTheme.light();
          // }
          return MaterialApp(
            title: 'Hero Admin',
            debugShowCheckedModeBanner: false,
            // theme: ThemeData(
            //   colorScheme: ColorScheme.fromSwatch(
            //       accentColor: kPrimaryColor,
            //       primarySwatch: Colors.green,
            //       cardColor: kPrimaryColor),
            // ),
            theme: theme,
            home: Router(
              routerDelegate: _appRouter,
              backButtonDispatcher: RootBackButtonDispatcher(),
            ),
          );
        },
      ),
    );
  }
}
