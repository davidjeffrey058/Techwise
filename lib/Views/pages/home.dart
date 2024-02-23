import 'package:flutter/material.dart';
import 'package:techwise_pub/Views/pages/NavigationBarScreens/new_profile_page.dart';
import 'NavigationBarScreens/home_tab.dart';
import 'NavigationBarScreens/category.dart';
import 'NavigationBarScreens/wishlist.dart';

class Home extends StatefulWidget {
  final String title;
  const Home({Key? key, required this.title}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var navIndex = 0;

  @override
  Widget build(BuildContext context) {
    // final user = Provider.of<UserProperties?>(context);
    final tabs = [
      HomeTab(title: widget.title),
      Category(),
      WishList(),
      NewProfilePage(),
    ];
    // DataServices().showImagePath(user?.uid);

    return Scaffold(
      backgroundColor: scaffoldBackgroundColor(navIndex),
      body: SafeArea(
        child: tabs[navIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navIndex,
        onTap: (index) {
          setState(() {
            navIndex = index;
          });
        },
        backgroundColor: Colors.white,
        elevation: 20,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
            // backgroundColor: colorPalette.mainBlue,
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.category_outlined),
            activeIcon: Icon(Icons.category),
            label: 'Category',
            // backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            activeIcon: Icon(Icons.favorite),
            label: 'Wishlist',
            // backgroundColor: Colors.red,
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
            // backgroundColor: Colors.purple,
          )
        ],
      ),
    );
  }

  Color scaffoldBackgroundColor(int index) {
    if (index == 0) {
      return Theme.of(context).colorScheme.secondary;
    } else {
      return Theme.of(context).colorScheme.primary;
    }
  }
}
