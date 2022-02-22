import 'package:flutter/material.dart';
import 'package:flutter_hero_admin_app/config/themes/hero_theme.dart';
import 'package:flutter_hero_admin_app/models/models.dart';
import 'package:flutter_hero_admin_app/viewmodels/viewmodels.dart';

import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  static MaterialPage page({required int currentTab, String? titleBar}) {
    return MaterialPage(
      name: HeroAdminPages.home,
      key: ValueKey(HeroAdminPages.home),
      child: HomeView(
        currentTab: currentTab,
      ),
    );
  }

  const HomeView({
    Key? key,
    required this.currentTab,
    this.titleBar,
  }) : super(key: key);

  final int currentTab;
  final String? titleBar;

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  static List<Widget> pages = [
    Container(
      child: const Center(child: Text('Task')),
      color: Colors.blue,
    ),
    Container(
      child: const Center(child: Text('Services')),
      color: Colors.green,
    ),
    Container(
      child: const Center(child: Text('Bookings')),
      color: Colors.red,
    ),
    Container(
      child: const Center(child: Text('Reports')),
      color: Colors.orange,
    ),
    Container(
      child: const Center(child: Text('Chats')),
      color: Colors.purple,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateManager>(
      builder: (context, appStateManager, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Manage ${appStateManager.titleBarStr}',
              style: HeroTheme.darkTextTheme.headline6,
            ),
            actions: [
              profileButton(),
            ],
          ),
          body: IndexedStack(
            //preserves state of the scrollbar and screens
            index: widget.currentTab,
            children: pages,
          ),
          bottomNavigationBar: BottomNavigationBar(
            showUnselectedLabels: true,
            currentIndex: widget.currentTab,
            onTap: (index) {
              appStateManager.goToTab(index);
              appStateManager.setTitleBarStr(index);
            },
            selectedItemColor:
                Theme.of(context).textSelectionTheme.selectionColor,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.explore),
                label: 'Task',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.book),
                label: 'Services',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.list),
                label: 'Bookings',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.list),
                label: 'Reports',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.list),
                label: 'Chats',
              ),
            ],
          ),
        );
      },
    );
  }

  Widget profileButton() {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: GestureDetector(
        child: const CircleAvatar(
          backgroundColor: Colors.transparent,
          //backgroundImage: AssetImage('assets/profile_pics/person_stef.jpeg'),
        ),
        onTap: () {
          Provider.of<ProfileViewmodel>(context, listen: false)
              .tapOnProfile(true);
        },
      ),
    );
  }
}
