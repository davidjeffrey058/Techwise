import 'package:flutter/material.dart';
import 'package:techwise_pub/color_palette.dart';

class TitleSection extends StatelessWidget {
  const TitleSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: ColorPalette().mainblueLter),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Row(
              children: [
                InkWell(
                  onTap: () => Navigator.pushNamed(context, '/example_page'),
                  child: Text(
                    'TECHWISE',
                    style: TextStyle(
                        fontSize: 25,
                        fontFamily: 'Bauhaus',
                        color: Theme.of(context).primaryColor),
                  ),
                ),
                Expanded(child: SizedBox()),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/cart');
                  },
                  child: Stack(clipBehavior: Clip.none, children: [
                    Icon(Icons.shopping_cart_outlined),
                    Positioned(
                      top: -10,
                      right: -5,
                      child: Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white,
                            )),
                        child: Text(
                          '3',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  ]),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 15),
            child: TextFormField(
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(9),
                    borderSide: BorderSide(color: Colors.white)),
                fillColor: Colors.white,
                filled: true,
                hintText: 'Search here...',
                suffixIcon: Icon(Icons.search),
              ),
            ),
          )
        ],
      ),
    );
  }
}
