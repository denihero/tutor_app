import 'package:flutter/material.dart';
import 'package:tutor_app/src/presentation/components/appbars/transparent_appbar.dart';
import 'package:tutor_app/src/presentation/components/custom_search.dart';
import 'package:tutor_app/src/presentation/screens/home/pages/favorite_page.dart';
import 'package:tutor_app/src/presentation/screens/home/pages/home_page.dart';
import 'package:tutor_app/src/presentation/screens/home/pages/profile_page.dart';
import 'package:tutor_app/src/presentation/screens/settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  void onBottomNavBarTap(int index) {
    setState(() {
      _currentIndex = index;
      _pageController.animateToPage(
        index,
        curve: Curves.decelerate,
        duration: const Duration(milliseconds: 300),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: [
        const TransparentAppBar(
          title: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: CustomSearch(),
          ),
        ),
        const TransparentAppBar(
          title: Text(
            "Избранное",
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.04,
            ),
          ),
        ),
        TransparentAppBar(
          title: const Text(
            "Профиль",
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.04,
            ),
          ),
          action: Padding(
            padding: const EdgeInsets.only(right: 22),
            child: IconButton(
              icon: const Icon(
                Icons.settings,
                color: Color(0xFFFE793D),
                size: 30,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SettingsScreen(),
                  ),
                );
              },
            ),
          ),
        ),
      ][_currentIndex],
      body: SafeArea(
        child: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: const [
            HomePage(),
            FavoritePage(),
            ProfilePage(),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Color(0xFFC2D1E5),
              offset: Offset(0, -1),
              blurRadius: 11,
            )
          ],
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(26),
            topLeft: Radius.circular(26),
          ),
        ),
        child: BottomNavigationBar(
          elevation: 0,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: const Color(0xFFFE793D),
          unselectedItemColor: Colors.black,
          currentIndex: _currentIndex,
          onTap: (index) => onBottomNavBarTap(index),
          items: [
            navBarIcon(Icons.home),
            navBarIcon(Icons.favorite),
            navBarIcon(Icons.person_sharp),
          ],
        ),
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
