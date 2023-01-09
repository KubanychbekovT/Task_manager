import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:systemforschool/utils/constants.dart';

class CustomAppBar extends AppBar {
  final String? textTitle;
  final TextStyle? textStyle;
  final IconData? leadingIconData;
  final List<Widget> actions;
  CustomAppBar({
    Key? key,
    this.textTitle,
    this.actions=const [],
    this.textStyle,
    this.leadingIconData,
  }) : super(key: key);

  @override
  State<AppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: Container(
          height: 46,
          child: AppBar(
            systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: AppConstants.primaryColor,statusBarIconBrightness: Brightness.light,statusBarBrightness: Brightness.dark,),
            backgroundColor: AppConstants.primaryColor,
            actions: widget.actions,
            // shape: const RoundedRectangleBorder(
            //   borderRadius: BorderRadius.all(Radius.circular(8)),
            // ),
            // leading: IconButton(
            //   onPressed: () {},
            //   icon: Icon(widget.leadingIconData),
            // ),
            elevation: 0,
            titleTextStyle: widget.textStyle,
            title: Text(widget.textTitle ?? 'Task-manager'),
          ),
        ),
      ),
    );
  }
}