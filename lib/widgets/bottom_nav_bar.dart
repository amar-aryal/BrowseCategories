import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home_outlined,
            color: Colors.orange[600],
            size: MediaQuery.of(context).size.height * 0.05,
          ),
          label: "",
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.star_outline_rounded,
            color: Colors.orange[600],
            size: MediaQuery.of(context).size.height * 0.05,
          ),
          label: "",
        ),
      ],
    );
  }
}
