import 'package:flutter/material.dart';

import 'addFriend/addfriend.dart';
import 'addFriend/friendlist.dart';
import 'login/email_login.dart';

class Navbar extends StatefulWidget {
  const Navbar({Key? key}) : super(key: key);

  @override
  _NavbarState createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Friend',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'setting',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.teal[800],
        onTap: (index){
          switch(index) {
            case 0:
              Navigator.pushNamed(context, "/friend");
              break;
            case 1:
              Navigator.pushNamed(context, "/chat");
              break;
          }
        },
      );
  }
}
