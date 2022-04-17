import 'package:flutter/material.dart';
import 'package:tutor_app/src/ui/screens/home/pages/favorite_page.dart';
import 'package:tutor_app/src/ui/screens/home/pages/home_page.dart';
import 'package:tutor_app/src/ui/screens/home/pages/profile_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController _pageController = PageController();
  int _currentIndex = 0;

  void onBottomNavBarTap(int index) {
    setState(() {
      _currentIndex = index;
      _pageController.animateToPage(
        index,
        curve: Curves.decelerate,
        duration: Duration(milliseconds: 300),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView(
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),
          children: [
            HomePage(),
            FavoritePage(),
            ProfilePage(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Color(0xFFFE793D),
        unselectedItemColor: Colors.black,
        currentIndex: _currentIndex,
        onTap: (index) => onBottomNavBarTap(index),
        items: [
          navBarIcon(Icons.home),
          navBarIcon(Icons.favorite),
          navBarIcon(Icons.person_sharp),
        ],
      ),
    );
  }

  BottomNavigationBarItem navBarIcon(IconData icon) => BottomNavigationBarItem(
        icon: Icon(
          icon,
          size: 30,
        ),
        label: "",
      );
}
