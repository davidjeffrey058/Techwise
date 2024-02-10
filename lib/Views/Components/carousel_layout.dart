import 'package:flutter/material.dart';
// import 'package:carousel_slider/carousel_slider.dart';

// ignore: must_be_immutable
class CarouselLayout extends StatelessWidget {

  String value;
  CarouselLayout({required this.value, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: Colors.blue[100],
        image: DecorationImage(
          image: NetworkImage(value),
          fit: BoxFit.cover
        ),
        borderRadius: BorderRadius.circular(8)
        ),
    );
  }
}