import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:techwise_pub/Controller/Cubit/theme_switch.dart';
import 'package:techwise_pub/Views/Authentication/wrapper.dart';
import 'package:techwise_pub/Models/user_properties.dart';
import 'package:techwise_pub/others/mode_switch.dart';
import 'package:techwise_pub/Views/pages/cart.dart';
import 'package:techwise_pub/Views/pages/checkout.dart';
import 'package:techwise_pub/Views/pages/example_page.dart';
import 'package:techwise_pub/Views/pages/game_page.dart';
import 'package:techwise_pub/Views/pages/imageViewer.dart';
import 'package:techwise_pub/Views/pages/product_page.dart';
import 'package:techwise_pub/services/authenticaiton_services.dart';
import 'Views/pages/home.dart';
import 'Views/pages/loading.dart';
import 'Views/pages/product_category.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MultiProvider(providers: [
    StreamProvider<UserProperties?>(
        create: (context) => AuthenticationServices().authenticationState,
        initialData: null),
    ChangeNotifierProvider<ModeSwitch>(create: (context) => ModeSwitch()),
    // StreamProvider<ProductProperties?>(create: (context) => DataServices().getData, initialData: null,)
  ], child: BlocProvider(create: (context) => ThemeSwitch(), child: MyApp())));
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  MyApp({super.key});

  ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: const Color(0xff0074A6),
    appBarTheme: AppBarTheme(
      backgroundColor: const Color(0xff0074A6),
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(color: Colors.white, fontSize: 15),
    ),
    brightness: Brightness.light,
    useMaterial3: true,
    textTheme: TextTheme(
      labelMedium: TextStyle(fontSize: 15, color: Colors.white),
      labelSmall: TextStyle(fontSize: 12, color: Colors.white),
      displayMedium: TextStyle(
          fontSize: 13, color: Color(0xff0074A6), fontWeight: FontWeight.bold),
    ),
    colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xff0074A6),
        primary: const Color(0xff0074A6),
        secondary: Color(0xffE3EBEF)),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
      textStyle: MaterialStatePropertyAll(
          TextStyle(color: Colors.white, fontSize: 14)),
      iconColor: MaterialStatePropertyAll(Colors.white),
      backgroundColor: MaterialStatePropertyAll(const Color(0xff0074A6)),
      shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
    )),
  );

  ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color.fromARGB(115, 36, 36, 36),
      inputDecorationTheme:
          InputDecorationTheme(filled: false, fillColor: Colors.transparent));

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeSwitch, bool>(
      bloc: ThemeSwitch(),
      builder: (context, state) {
        return MaterialApp(
          title: 'Techwise',
          onGenerateTitle: (context) {
            return 'Techwise';
          },
          initialRoute: '/wrapper',
          routes: {
            '/loading': (context) => const Loading(),
            '/home': (context) => const Home(),
            '/cart': (context) => const Cart(),
            '/product_category': (context) => const ProductCategoryPage(),
            '/product_page': (context) => const ProductPage(),
            '/checkout': (context) => const CheckOut(),
            '/image_viewer': (context) => ImageViewer(),
            '/game_page': (context) => GamePage(),
            '/wrapper': (context) => Wrapper(),
            '/example_page': (context) => ExamplePage(),
          },
          debugShowCheckedModeBanner: false,
          theme: state ? darkTheme : lightTheme,
        );
      },
    );
  }
}
