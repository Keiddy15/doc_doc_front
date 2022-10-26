// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomNavigationComponent extends StatelessWidget {
  const BottomNavigationComponent(
      {Key? key, required this.index, required this.onTapFunction})
      : super(key: key);

  final int index;
  final void Function(int) onTapFunction;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Colors.white,
            border: Border.all(color: Colors.white)),
        margin: EdgeInsets.symmetric(horizontal: 25.0),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(25.0),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: index,
              onTap: onTapFunction,
              selectedItemColor: const Color(0xFF00CEC9),
              unselectedItemColor: Color.fromARGB(255, 188, 233, 230),
              iconSize: 20,
              backgroundColor: Colors.white,
              showUnselectedLabels: true,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                    icon: FaIcon(FontAwesomeIcons.commentMedical),
                    label: "Chat"),
                BottomNavigationBarItem(
                    icon: FaIcon(FontAwesomeIcons.userDoctor), label: "User"),
              ],
            )));
  }
}
