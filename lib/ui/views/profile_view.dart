import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_hero_admin_app/constants/app_spacing.dart';
import 'package:flutter_hero_admin_app/constants/colours.dart';
import 'package:flutter_hero_admin_app/viewmodels/profile_viewmodel.dart';
import 'package:provider/provider.dart';
//import 'package:url_launcher/url_launcher.dart';

import '../../models/models.dart';
import '../widgets/widgets.dart';

class ProfileView extends StatefulWidget {
  static MaterialPage page(User user) {
    return MaterialPage(
      name: HeroAdminPages.profilePath,
      key: ValueKey(HeroAdminPages.profilePath),
      child: ProfileView(user: user),
    );
  }

  final User user;
  const ProfileView({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Provider.of<ProfileViewmodel>(context, listen: false)
                .tapOnProfile(false);
          },
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 16.0),
            buildProfile(),
            Expanded(
              child: buildMenu(),
            )
          ],
        ),
      ),
    );
  }

  Widget buildTextField(String labelText) {
    return Column(
      children: [
        SizedBoxSpacing.height10,
        TextField(
          obscureText: true,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: labelText,
          ),
        ),
      ],
    );
  }

  Widget buildButton(String title) {
    // return SizedBox(
    //   height: 55,
    //   child: MaterialButton(
    //     color: kPrimaryColor,
    //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
    //     child: Text(
    //       title,
    //       style: const TextStyle(color: Colors.white),
    //     ),
    //     onPressed: () {
    //       print('test');
    //     },
    //   ),
    // );

    return ElevatedButton(
      style: ElevatedButton.styleFrom(primary: kPrimaryColor),
      onPressed: () {
        print('test');
      },
      child: Text('SAVE'),
    );
  }

  Widget buildMenu() {
    return ListView(
      children: [
        //buildDarkModeRow(),
        // ListTile(
        //   title: const Text('View raywenderlich.com'),
        //   onTap: () async {
        //     if (kIsWeb) {
        //       //await launch('https://www.raywenderlich.com/');
        //     } else {
        //       Provider.of<ProfileViewmodel>(context, listen: false)
        //           .tapOnRaywenderlich(true);
        //     }
        //   },
        // ),

        buildTextField('First Name'),

        buildTextField('Last Name'),

        buildTextField('Email'),
        buildTextField('Password'),

        buildButton('SAVE'),
        OutlinedButton(
          child: const Text('LOG OUT'),
          onPressed: () {
            // 1
            Provider.of<ProfileViewmodel>(context, listen: false)
                .tapOnProfile(false);
            // 2
            Provider.of<AppStateManager>(context, listen: false).logout();
          },
        ),
      ],
    );
  }

  Widget buildText(String text) => Column(
        children: [
          SizedBoxSpacing.height10,
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              text,
            ),
          )
        ],
      );

  Widget buildDarkModeRow() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Dark Mode'),
          Switch(
            value: widget.user.darkMode,
            onChanged: (value) {
              Provider.of<ProfileViewmodel>(context, listen: false).darkMode =
                  value;
            },
          )
        ],
      ),
    );
  }

  Widget buildProfile() {
    return Column(
      children: [
        CircleImage(
          imageProvider: AssetImage(widget.user.profileImageUrl!),
          imageRadius: 60.0,
        ),
        const SizedBox(height: 16.0),
        Text(
          widget.user.firstName,
          style: const TextStyle(fontSize: 21),
        ),
        // Text(widget.user.role),
        // Text(
        //   '${widget.user.points} points',
        //   style: const TextStyle(
        //     fontSize: 30,
        //     color: Colors.green,
        //   ),
        // ),
      ],
    );
  }
}
