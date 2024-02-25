import 'package:flutter/material.dart';

class SpecialProductSection extends StatelessWidget {
  final PageController pageController;
  final List productInfoList;
  final void Function(int)? onPageChanged;
  final void Function()? next;
  final void Function()? previous;
  const SpecialProductSection(
      {super.key,
      required this.productInfoList,
      this.onPageChanged,
      required this.pageController,
      this.next,
      this.previous});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width / 1.6,
      child: Stack(
        children: [
          PageView(
            controller: pageController,
            onPageChanged: onPageChanged,
            children: productInfoList.map((e) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Container(
                    decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.black12,
                              spreadRadius: 3,
                              blurRadius: 3)
                        ],
                        image: DecorationImage(
                            image: AssetImage(
                                'images/product_images/${e.productImage}'),
                            fit: BoxFit.cover)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 9, horizontal: 25),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              e.productName,
                              style: TextStyle(
                                  fontSize: 15,
                                  backgroundColor:
                                      Colors.black.withOpacity(0.2),
                                  color: Colors.white),
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                elevation: 2,
                                backgroundColor: Colors.transparent,
                                side: BorderSide(color: Colors.white, width: 1),
                                shape: RoundedRectangleBorder()),
                            onPressed: () {},
                            child: Text(
                              'Buy Now',
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                          ),
                        ],
                      ),
                    )),
              );
            }).toList(),
            padEnds: false,
          ),
          Positioned(
            top: ((MediaQuery.of(context).size.width / 1.6) / 2) - 30,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: 10,),
                  roundNavigationButton(true),
                  Spacer(),
                  roundNavigationButton(false),
                  SizedBox(width: 10,)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  roundNavigationButton(bool isLeft) {
    return InkWell(
      onTap: isLeft ? previous : next,
      child: Container(
        height: 55,
        width: 55,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white,
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 6,
                  offset: Offset(0, 0))
            ]),
        child: Center(
          child: Icon(
            isLeft ? Icons.arrow_back_ios_new : Icons.arrow_forward_ios,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
