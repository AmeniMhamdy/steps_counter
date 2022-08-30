import 'package:flutter/material.dart';
import 'package:steps_counter/dahboard.dart';
import 'package:steps_counter/widget/activityreco.dart';
import 'package:steps_counter/widget/doc.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(),
      body: IndexedStack(
        index: currentPageIndex,
        children: [Dashboard(), Doctor(), ActivityRecognitionApp()],
      ), //
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.white,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(
              Icons.home,
            ),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.health_and_safety,
            ),
            label: 'Health',
          ),
          NavigationDestination(
            selectedIcon: Icon(
              Icons.account_circle_rounded,
            ),
            icon: Icon(
              Icons.account_circle_rounded,
            ),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}
