import 'package:flutter/material.dart';
import 'package:kn_restaurant/screens/add.dart';
import 'package:kn_restaurant/screens/home.dart';
import 'package:kn_restaurant/screens/cart_screen.dart';
import 'package:kn_restaurant/screens/profile.dart';
import 'history.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late PageController _pageController;
  int _page = 0;

  List icons = [
    Icons.home,
    Icons.shopping_cart,
    Icons.add,
    Icons.history_outlined,
    Icons.person,
  ];

  List pages = [
    const Home(),
    const CartScreen(),
    const Add(),
    const Histories(),
    const Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        onPageChanged: onPageChanged,
        children: List.generate(5, (index) =>  pages[index] ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).primaryColor,
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            // SizedBox(width: 7),
            buildTabIcon(0),
            buildTabIcon(1),
            buildTabIcon(3),
            buildTabIcon(4),
            // SizedBox(width: 7),
          ],
        ),
      ),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        elevation: 10.0,
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        child: const Icon(
          Icons.add,
        ),
        onPressed: () => _pageController.jumpToPage(2),
      ),
    );
  }

 // void navigationTapped(int page) {
 //    _pageController.jumpToPage(page);
 //  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  buildTabIcon(int index) {
      return Container(
        margin: EdgeInsets.fromLTRB( index == 3 ? 30 : 0, 0,  index == 1 ? 30 : 0, 0),
        child: IconButton(
          icon: Icon(
            icons[index],
            size: 24.0,
          ),
          color: _page == index
              ? Theme.of(context).colorScheme.secondary
              : Theme.of(context).textTheme.bodySmall?.color,
          onPressed: () => _pageController.jumpToPage(index),
        ),
      );
  }
}
