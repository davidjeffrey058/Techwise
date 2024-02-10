import 'package:flutter/material.dart';
import 'home_tab.dart';
import 'category.dart';
import 'wishlist.dart';
import 'profile.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // dynamic statusColor = Color(0xff0074A6);
  var navIndex = 0;
  final tabs = [HomeTab(), Category(), WishList(), Profile()];

  @override
  Widget build(BuildContext context) {
    // final user = Provider.of<UserProperties?>(context);

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
            // switch(index){
            //   case 0:{
            //     statusColor = colorPalette.mainBlue;
            //     break;
            //   }
            //   case 1:{
            //     statusColor = Colors.green;
            //     break;
            //   }
            //   case 2:{
            //     statusColor = Colors.red;
            //     break;
            //   }
            //   case 3:{
            //     statusColor = Colors.purple;
            //     break;
            //   }
            // }
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
