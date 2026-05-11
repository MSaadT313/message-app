import 'package:flutter/material.dart';
import 'package:message_app_flutter/Services/authentication/auth_service.dart';

import '../pages/settings_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});
void logout(){
  //get auth service
  final auth = AuthService();
  auth.signOut();
}
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(children: [
            //logo
            DrawerHeader(
              child: Center(
                child: Icon(
                  Icons.message,
                  color: Theme.of(context).colorScheme.primary,
                  size: 40,
                ),
              ),
            ),
            //home list
            Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: ListTile(
                title: Text("واپسی"),
                leading: Icon(Icons.home),
                onTap:(){
                  //pop the drawer
                  Navigator.pop(context);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: ListTile(
                title: Text("تبدیلی"),
                leading: Icon(Icons.settings),
                onTap:(){
                  Navigator.pop(context);
                  Navigator.push(context,
                    MaterialPageRoute(
                      builder: (context) => SettingsPage(),
                  ),
                  );
                },
              ),
            ),

          ],),
          Padding(
            padding: const EdgeInsets.only(left: 25.0, bottom: 40),
            child: ListTile(
              title: Text(" لاگ آؤٹ "),
              leading: Icon(Icons.logout),
              onTap: logout,
            ),
          ),

        ],
      ),
    );
  }

}
