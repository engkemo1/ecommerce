// ignore_for_file: file_names, prefer_const_literals_to_create_immutables, prefer_const_constructors


import 'package:ecommerce/constants.dart';
import 'package:flutter/material.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  PageController pageController = PageController();
  final List<Widget> screens = <Widget>[

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: IndexedStack(index: _selectedIndex, children: screens),
      bottomNavigationBar: ClipRRect(
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,

          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage("images/bottomnavbaritem_1.png"),
                size: 30,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage("images/bottomnavbaritem_2.png"),
                size: 30,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage("images/bottomnavbaritem_3.png"),
                size: 60,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage("images/bottomnavbaritem_4.png"),
                size: 60,
              ),
              label: '',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Color(0xffFA4A0C),
          unselectedItemColor: Color(0xffB1B1B3),
          selectedFontSize: 14,
          unselectedFontSize: 14,
          onTap: (index) => setState(() => _selectedIndex = index),
        ),
      ),
    );
  }
}
