import 'package:flutter/material.dart';
import 'package:systemforschool/utils/constants.dart';
import 'package:systemforschool/view/widgets/custom_app_bar.dart';

class CustomScaffold extends StatelessWidget {
  final EdgeInsetsGeometry? padding;
  final Widget body;
  final Widget? floatingActionButton;
  final bool isScrolling;
  final String? appBarTitle;
  final BottomNavigationBar? bottomNavigationBar;
  final bool useAppBar;
  final List<Widget> actions;
  const CustomScaffold({
    Key? key,
    required this.body,
    this.floatingActionButton,
    this.padding,
    this.useAppBar=true,
    this.bottomNavigationBar,
    this.actions=const [],
    this.isScrolling = false,
    this.appBarTitle = 'Custom Widgets',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(242, 244, 255, 1),
      appBar: useAppBar?CustomAppBar(textTitle: appBarTitle,
        actions: actions,
      ):null,
      body: Padding(
        padding: padding ??
            EdgeInsets.symmetric(
              horizontal: 5
            ),
        child: isScrolling
            ? SingleChildScrollView(
          child: body,
        )
            : body,
      ),
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
    );
  }
}