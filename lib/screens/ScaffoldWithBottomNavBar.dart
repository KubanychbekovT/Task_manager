import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:systemforschool/screens/chat_screen.dart';
import 'package:systemforschool/screens/details_screen.dart';
import 'package:systemforschool/screens/home_screen.dart';

class ScaffoldWithBottomNavBar extends StatefulWidget {
  final Widget child;
  const ScaffoldWithBottomNavBar({Key? key,required this.child}) : super(key: key);

  @override
  State<ScaffoldWithBottomNavBar> createState() => _ScaffoldWithBottomNavBarState();
}

class _ScaffoldWithBottomNavBarState extends State<ScaffoldWithBottomNavBar> {

  // getter that computes the current index from the current location,
  // using the helper method below
  int get _currentIndex => _locationToTabIndex(GoRouter.of(context).location);

  int _locationToTabIndex(String location) {
    final index =
    tabs.indexWhere((t) => location==(t.initialLocation));
    // if index not found (-1), return 0
    return index < 0 ? 0 : index;
  }

  //callback used to navigate to the desired tab
  void _onItemTapped(BuildContext context, int tabIndex) {
    if (tabIndex != _currentIndex) {
      // go to the initial location of the selected tab (by index)
      context.go(tabs[tabIndex].initialLocation);
    }
  }
final List<Widget> _mainContents = [
  HomeScreen(label: 'A'),
  DetailsScreen(label: 'B'),
  ChatScreen(label: 'C'),
];

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Scaffold(
        body: widget.child,
      bottomNavigationBar: MediaQuery.of(context).size.width < 640
          ? BottomNavigationBar(
        currentIndex: _currentIndex,
        items: tabs,
        onTap: (index) => _onItemTapped(context, index),
      )
          : Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          if (MediaQuery.of(context).size.width >= 640)
            NavigationRail(
                minWidth: 55.0,
                selectedIndex: _selectedIndex,
            onDestinationSelected: (index) => _onItemTapped(context, index),
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
                  label: Text('Scetion A',
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

          Expanded(child: _mainContents[_currentIndex]),
        ],
      )
    ),
    );
  }
}
class ScaffoldWithNavBarTabItem extends BottomNavigationBarItem {
  const ScaffoldWithNavBarTabItem(
      {required this.initialLocation, required Widget icon, String? label})
      : super(icon: icon, label: label);

  /// The initial location/path
  final String initialLocation;
}
const tabs = [
  ScaffoldWithNavBarTabItem(
    initialLocation: '/a',
    icon: Icon(Icons.home),
    label: 'Section A',
  ),
  ScaffoldWithNavBarTabItem(
    initialLocation: '/b',
    icon: Icon(Icons.settings),
    label: 'Section B',
  ),
  ScaffoldWithNavBarTabItem(
    initialLocation: '/c',
    icon: Icon(Icons.chat),
    label: 'Section C',
  ),
];