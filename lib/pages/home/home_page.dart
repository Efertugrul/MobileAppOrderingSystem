import 'package:flutter/material.dart';
import 'package:food_delivery_app/pages/cart/cart_history_page.dart';
import 'package:food_delivery_app/pages/cart/cart_page.dart';
import 'package:food_delivery_app/pages/home/main_menu_page.dart';
import 'package:food_delivery_app/pages/profile/profile_page.dart';
import 'package:food_delivery_app/utils/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController(initialPage: 0);

  void onTapNav(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (newIndex) {
          setState(() {
            _selectedIndex = newIndex;
          });
        },
        children: [MainMenuPage(), CartPage(), CartHistory(), ProfilePage()],
      ),
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: AppColors.orangeColor,
          unselectedItemColor: Colors.grey,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedFontSize: 0.0,
          unselectedFontSize: 0.0,
          onTap: (index) {
            _pageController.animateToPage(index,
                duration: const Duration(microseconds: 500),
                curve: Curves.ease);
          },
          currentIndex: _selectedIndex,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined), label: "home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart_outlined), label: "cart"),
            BottomNavigationBarItem(
                icon: Icon(Icons.archive_outlined), label: "history"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "profile"),
          ]),
    );
  }
}
