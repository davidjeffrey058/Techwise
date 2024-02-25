import 'package:flutter/material.dart';

class CustomIcon extends StatelessWidget {
  final String iconName;
  final double? width;
  final double? height;
  final Color? color;
  final bool isColored;

  const CustomIcon(
      {super.key,
      required this.iconName,
      this.width,
      this.height,
      this.color,
      this.isColored = true});

  @override
  Widget build(BuildContext context) {

    Color? iconColor() {
      if(!isColored && color != null){
        return color;
      }
      return null;
    }

    return SizedBox(
      width: width ?? 24,
      height: height ?? 24,
      child: Image(image: AssetImage('images/icons/$iconName'), color: iconColor(), fit: BoxFit.contain,),
    );
  }
}
