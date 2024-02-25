import 'package:flutter/material.dart';

class ProductLoading extends StatelessWidget {
  const ProductLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 170,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            myContainer(
              height: 130,
            ),
            const SizedBox(height: 5,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                myContainer(width: 120, radius: 5),
                myContainer(width: 20, radius: 5)
              ],
            ),
            const SizedBox(height: 5,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                myContainer(width: 70, radius: 5),
                const Spacer(),
                myContainer(width: 20, radius: 5),
                const SizedBox(width: 2,),
                myContainer(width: 15, height: 15, radius: 5)
              ],
            ),
          ],
        ),
      ),
    );
  }
  Container myContainer({
    double? height,
    double? width,
    double? radius
}){
    return Container(
      width: width ?? 150,
      height: height ?? 20,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius ?? 10),
        color: Colors.grey[300],
      ),
    );
  }
}
