import 'package:flutter/material.dart';
import 'package:systemforschool/utils/constants.dart';
import 'package:systemforschool/view/screens/profile_screen.dart';
import 'package:systemforschool/view/screens/projects_screen.dart';
import 'package:systemforschool/view/widgets/custom_scaffold.dart';

import 'chat_screen.dart';
import 'home_screen.dart';

class NavbarScreen extends StatefulWidget {
  const NavbarScreen({Key? key}) : super(key: key);
  @override
  State<NavbarScreen> createState() => _NavbarScreenState();
}

class _NavbarScreenState extends State<NavbarScreen> {
  int currentIndex=0;
final List<Widget> _mainContents = [
  HomeScreen(),
  MyProjectsScreen(),
  ProfileScreen(),
];
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Scaffold(
        body: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            if(MediaQuery.of(context).size.width > 640)...[
            NavigationRail(
              minWidth: 55.0,
              selectedIndex: currentIndex,
              onDestinationSelected: (index) => setState(() {
                currentIndex=index;
              }),
              selectedIconTheme: IconThemeData(color:AppConstants.primaryColor),
              selectedLabelTextStyle:TextStyle(color:AppConstants.primaryColor ),
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
                  label: Text("Главная"),
                ),
                NavigationRailDestination(
                    icon: Icon(Icons.account_tree_outlined),
                    label: Text("Проекты")
                ),
                NavigationRailDestination(
                    icon: Icon(Icons.person),
                    label: Text("Профиль")),
              ],
            )],
            Expanded(
              child: IndexedStack(index:currentIndex,children:
              _mainContents
                ,),
            )
            //Expanded(child: _mainContents[currentIndex])
          ],
        ),
      bottomNavigationBar: MediaQuery.of(context).size.width < 640
          ? BottomNavigationBar(
        currentIndex: currentIndex,
        selectedItemColor: AppConstants.primaryColor,
        items: tabs,
        onTap: (index) => setState(() {
          currentIndex=index;
        }),
      )
          : null
    ),
    );
  }
}

var tabs = [
  BottomNavigationBarItem(
    icon: Icon(Icons.home),
    label: "Главная",
  ),
  BottomNavigationBarItem(
      icon: Icon(Icons.account_tree_outlined),
      label: "Проекты"
  ),
  BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: "Профиль"),

];