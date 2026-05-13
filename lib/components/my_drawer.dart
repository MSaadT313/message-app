import 'package:flutter/material.dart';
import 'package:message_app_flutter/global_variables.dart';
import 'package:message_app_flutter/Services/authentication/auth_service.dart';
import 'package:message_app_flutter/pages/friends_page.dart';

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
      backgroundColor: Theme.of(context).colorScheme.surface.withValues(alpha: drawerOpacity),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(drawerBorderRadius),
          bottomRight: Radius.circular(drawerBorderRadius),
        ),
      ),
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
                  size: drawerIconSize * 1.5,
                ),
              ),
            ),
            
            
            
            //home list
            Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: ListTile(
                title: Text("واپسی", style: TextStyle(fontSize: fontSizeBody)),
                leading: Icon(Icons.home, size: drawerIconSize),
                onTap:(){
                  //pop the drawer
                  Navigator.pop(context);
                },
              ),
            ),
            


            Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: ListTile(
                title: Text("دوست", style: TextStyle(fontSize: fontSizeBody)),
                leading: Icon(Icons.people_sharp, size: drawerIconSize),
                hoverColor: Color.fromARGB(0, 7, 238, 134),
                onTap:(){
                  //pop the drawer
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => FriendsPage()));
                },
              ),
            ),
            
            
            
            Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: ListTile(
                title: Text("تبدیلی", style: TextStyle(fontSize: fontSizeBody)),
                leading: Icon(Icons.settings, size: drawerIconSize),
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
              title: Text(" لاگ آؤٹ ", style: TextStyle(fontSize: fontSizeBody)),
              leading: Icon(Icons.logout, size: drawerIconSize),
              onTap: logout,
            ),
          ),

        ],
      ),
    );
  }

}


