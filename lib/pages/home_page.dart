import 'package:flutter/material.dart';
import 'package:message_app_flutter/components/my_drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( title: Text("Home"),
      ),
      drawer: MyDrawer(
      ),
    );
  }
}
