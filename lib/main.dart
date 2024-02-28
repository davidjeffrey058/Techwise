import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:techwise_pub/Views/Authentication/wrapper.dart';
import 'package:techwise_pub/Models/user_properties.dart';
import 'package:techwise_pub/States/mode_switch.dart';
import 'package:techwise_pub/Views/pages/cart.dart';
import 'package:techwise_pub/Views/pages/checkout.dart';
import 'package:techwise_pub/Views/pages/example_page.dart';
import 'package:techwise_pub/Views/pages/game_page.dart';
import 'package:techwise_pub/Views/pages/image_viewer.dart';
import 'package:techwise_pub/Views/pages/product_page.dart';
import 'package:techwise_pub/Views/pages/profile_page_screens/recently_viewed.dart';
import 'package:techwise_pub/Views/pages/profile_page_screens/my_order/my_orders.dart';
import 'package:techwise_pub/Views/pages/profile_page_screens/vouchers/vouchers.dart';
import 'package:techwise_pub/Views/pages/search_page.dart';
import 'package:techwise_pub/services/authenticaiton_services.dart';
import 'package:techwise_pub/theme.dart';
import 'Views/pages/home.dart';
import 'Views/pages/loading.dart';
import 'Views/pages/product_category.dart';

void main() async {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp
  ]);
  final title = 'Techwise';
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MultiProvider(providers: [
    StreamProvider<UserProperties?>(
        create: (context) => AuthenticationServices().authenticationState,
        initialData: null),
    ChangeNotifierProvider<ModeSwitch>(create: (context) => ModeSwitch()),
    // StreamProvider<ProductProperties?>(create: (context) => DataServices().getData, initialData: null,)
  ], child: MyApp(title: title)));
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  final String title;
  MyApp({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Techwise',
      onGenerateTitle: (context) {

        return 'Techwise';
      },
      initialRoute: '/wrapper',
      routes: {
        '/loading': (context) => const Loading(),
        '/home': (context) => Home(title: title),
        '/cart': (context) => const Cart(),
        '/product_category': (context) => const ProductCategoryPage(),
        '/product_page': (context) => const ProductPage(),
        '/checkout': (context) => const CheckOut(),
        '/image_viewer': (context) => ImageViewer(),
        '/game_page': (context) => GamePage(),
        '/wrapper': (context) => Wrapper(title: title),
        '/example_page': (context) => ExamplePage(),
        '/search_page': (context) => SearchPage(),
        '/my_orders' : (context) => MyOrders(),
        '/vouchers' : (context) => Vouchers(),
        '/recently_viewed': (context) => RecentlyViewed()
      },
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ModeSwitch>(context).isDark ? darkTheme : lightTheme,
    );
  }
}
