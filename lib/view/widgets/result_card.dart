import 'package:flutter/material.dart';
import 'package:systemforschool/utils/styles.dart';

class ResultCard extends StatelessWidget {
  const ResultCard(this.message,this.icon,{Key? key}) : super(key: key);
  final String message;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:  [
          Icon(
            icon, size: 128, color: Colors
              .black,),
          Text(message, style: Styles.headerStyle,
            textAlign: TextAlign.center,)
        ],),
    );
  }
}
