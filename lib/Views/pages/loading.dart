import 'package:flutter/material.dart';
import 'package:techwise_pub/color_palette.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 6), (){
      Navigator.pushReplacementNamed(context, '/login');
    });
  }
  ColorPalette colorPalette = ColorPalette();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              colorPalette.mainBlue,
              colorPalette.mainBlueLt
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter
          )
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'Techwise',
                style: TextStyle(
                  fontSize: 48,
                  color: Colors.white,
                  fontFamily: 'Bauhaus'
                ),
              ),
              SpinKitFadingFour(
                color: Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }
}
