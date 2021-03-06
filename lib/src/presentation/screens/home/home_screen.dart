import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:tutor_app/src/logic/blocs/authetication/authentication_bloc.dart';
import 'package:tutor_app/src/presentation/screens/home/pages/favorite_page.dart';
import 'package:tutor_app/src/presentation/screens/home/pages/home_page.dart';
import 'package:tutor_app/src/presentation/screens/home/pages/profile_page.dart';
import 'package:tutor_app/src/presentation/screens/settings_screen.dart';

import '../../components/custom_search.dart';
import '../../components/appbars/transparent_appbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  late String token;

  @override
  void initState() {
    super.initState();
    token = BlocProvider.of<AuthBloc>(context).state.token;
  }

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
        TransparentAppBar(
          title: Column(
            children: const [
              SizedBox(
                height: 10,
              ),
              CustomSearch(),
            ],
          ),
          action: Container(),
        ),
        TransparentAppBar(
          title: Text(
            "Избранное",
            style: TextStyle(
              color: Colors.black,
              fontSize: 15.sp,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.04,
            ),
          ),
        ),
        TransparentAppBar(
          title: Text(
            "Профиль",
            style: TextStyle(
              color: Colors.black,
              fontSize: 15.sp,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.04,
            ),
          ),
          action: Padding(
            padding: const EdgeInsets.only(right: 5),
            child: IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SettingsScreen()));
                },
                icon: const Icon(
                  Icons.settings,
                  color: Color(0xFFFE793D),
                  size: 35,
                )),
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
