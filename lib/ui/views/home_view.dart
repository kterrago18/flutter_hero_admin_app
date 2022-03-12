import 'package:flutter/material.dart';
import 'package:flutter_hero_admin_app/config/themes/hero_theme.dart';
import 'package:flutter_hero_admin_app/constants/colours.dart';
import 'package:flutter_hero_admin_app/models/models.dart';
import 'package:flutter_hero_admin_app/ui/views/views.dart';
import 'package:flutter_hero_admin_app/viewmodels/viewmodels.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
    const TasksView(),
    const ServicesView(),
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
    return Consumer<AppsModel>(
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
                icon: FaIcon(FontAwesomeIcons.clipboardCheck),
                label: 'Task',
              ),
              BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.solidBell),
                label: 'Services',
              ),
              BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.fileInvoice),
                label: 'Bookings',
              ),
              BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.solidFile),
                label: 'Reports',
              ),
              BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.solidComment),
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
          backgroundImage:
              AssetImage('assets/images/profile_pics/person_stef.jpeg'),
        ),
        onTap: () {
          Provider.of<ProfileModel>(context, listen: false).tapOnProfile(true);
        },
      ),
    );
  }
}
