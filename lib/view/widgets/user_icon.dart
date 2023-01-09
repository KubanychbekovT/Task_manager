import 'package:flutter/material.dart';

class UserIcon extends StatelessWidget {
  const UserIcon(this.name,{Key? key,}) : super(key: key);
  final String name;
  @override
  Widget build(BuildContext context) {
    final List<Color> listColor=[Colors.pinkAccent,Colors.deepOrangeAccent,Colors.purple,Colors.blue,Colors.orangeAccent,Colors.green,Colors.yellow];
    Color selectedColor;
    if(name[0].toLowerCase().contains(RegExp(r'[a-c]'))){
      selectedColor=listColor.first;
    }else if(name[0].toLowerCase().contains(RegExp(r'[d-g]'))){
      selectedColor=listColor[1];
    }else if(name[0].toLowerCase().contains(RegExp(r'[h-k]'))){
      selectedColor=listColor[2];
    }
    else if(name[0].toLowerCase().contains(RegExp(r'[l-p]'))){
      selectedColor=listColor[3];
    }
    else if(name[0].toLowerCase().contains(RegExp(r'[q-u]'))){
      selectedColor=listColor[4];
    }
    else if(name[0].toLowerCase().contains(RegExp(r'[v-z]'))){
      selectedColor=listColor[6];
    }
    else{
      selectedColor=listColor.last;
    }
    return Container(
      width: 30,
      child: CircleAvatar(
        backgroundColor: selectedColor,
        radius: 18,
        child: Text(
          name[0].toUpperCase(),
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
