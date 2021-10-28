import 'package:flutter/material.dart';
import 'package:flutter_task_planner_app/screens/home_page.dart';
import 'package:flutter_task_planner_app/screens/login_page.dart';
import 'package:flutter_task_planner_app/theme/colors/light_colors.dart';
import 'package:get/get.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => new _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      child: Padding(
        padding: const EdgeInsets.only(top: 25),
        child: new Drawer(
          child: Container(
            color: LightColors.kDarkBlue,
            child: ListView(
              padding: EdgeInsets.all(10.0),
              children: [
                ListTile(
                  onTap: () {
                    Get.offAll(() => HomePage());
                  },
                  leading: Icon(
                    Icons.home,
                    color: Colors.white,
                  ),
                  title: Text(
                    'Home Page',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                ListTile(
                  onTap: () {},
                  leading: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                  title: Text(
                    'Your Profile',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                // ListTile(
                //   onTap: () {},
                //   leading: Icon(
                //     Icons.settings,
                //     color: Colors.white,
                //   ),
                //   title: Text(
                //     'Setting',
                //     style: TextStyle(color: Colors.white),
                //   ),
                // ),
                ListTile(
                  onTap: () {
                    Get.offAll(() => LoginScreen());
                  },
                  leading: Icon(
                    Icons.logout,
                    color: Colors.white,
                  ),
                  title: Text(
                    'Logout',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
