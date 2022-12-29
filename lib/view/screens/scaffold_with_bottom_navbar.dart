import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:systemforschool/utils/constants.dart';
import 'package:systemforschool/view/screens/my_projects_screen.dart';

import 'chat_screen.dart';
import 'home_screen.dart';

class ScaffoldWithBottomNavBar extends StatefulWidget {
  const ScaffoldWithBottomNavBar({Key? key}) : super(key: key);
  @override
  State<ScaffoldWithBottomNavBar> createState() => _ScaffoldWithBottomNavBarState();
}

class _ScaffoldWithBottomNavBarState extends State<ScaffoldWithBottomNavBar> {

  int currentIndex=0;
final List<Widget> _mainContents = [
  HomeScreen(label: 'A'),
  MyProjectsScreen(),
  ChatScreen(label: 'C'),
];
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Scaffold(
        body: IndexedStack(index:currentIndex,children:
          _mainContents
        ,),
      bottomNavigationBar: MediaQuery.of(context).size.width < 640
          ? BottomNavigationBar(
        currentIndex: currentIndex,
        items: tabs,
        onTap: (index) => setState(() {
          currentIndex=index;
        }),
      )
          : Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          if (MediaQuery.of(context).size.width >= 640)
            NavigationRail(
                minWidth: 55.0,
                selectedIndex: currentIndex,
            onDestinationSelected: (index) => setState(() {
              currentIndex=index;
            }),
            labelType: NavigationRailLabelType.all,
              leading: Column(
                children: [
                  SizedBox(
                    height: 8,
                  ),
                ],
              ),
              unselectedLabelTextStyle: TextStyle(),
              destinations: [
                NavigationRailDestination(
                  icon: Icon(Icons.home),
                  label: Text('Section A',
                  ),
                ),
                NavigationRailDestination(
                    icon: Icon(Icons.settings),
                    label: Text('Section B')
            ),
           NavigationRailDestination(
                    icon: Icon(Icons.chat),
                    label: Text('Section C')),
              ],
            ),
          Expanded(child: _mainContents[currentIndex]),
        ],
      )
    ),
    );
  }
}
class ScaffoldWithNavBarTabItem extends BottomNavigationBarItem {
  const ScaffoldWithNavBarTabItem(
      { required Widget icon, String? label})
      : super(icon: icon, label: label);

}
var tabs = [
  ScaffoldWithNavBarTabItem(
    icon: Icon(Icons.home),
    label: 'Section A',
  ),
  ScaffoldWithNavBarTabItem(
    icon: Icon(Icons.settings),
    label: 'Section B',
  ),
  ScaffoldWithNavBarTabItem(
    icon: Icon(Icons.chat),
    label: 'Section C',
  ),
];