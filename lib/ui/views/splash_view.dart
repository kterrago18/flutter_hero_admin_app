import 'package:flutter/material.dart';
import 'package:flutter_hero_admin_app/models/models.dart';
import 'package:provider/provider.dart';

class SplashView extends StatefulWidget {
  static MaterialPage page() {
    return MaterialPage(
      name: HeroAdminPages.splashPath,
      key: ValueKey(HeroAdminPages.splashPath),
      child: const SplashView(),
    );
  }

  const SplashView({Key? key}) : super(key: key);

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<AppStateManager>(context, listen: false).initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            FlutterLogo(),
            Text('Initializing...'),
          ],
        ),
      ),
    );
  }
}
