import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CartItemLayout extends StatelessWidget {
  final Function()? increase;
  final Function()? decrease;
  final Function()? remove;
  final int index;
  final List list;

  const CartItemLayout(
      {super.key,
      this.increase,
      this.decrease,
      this.remove,
      required this.index,
      required this.list});

  @override
  Widget build(BuildContext context) {
    int itemQuantity = list[index].numOfOrder;
    return Container(
      clipBehavior: Clip.hardEdge,
      margin: EdgeInsets.fromLTRB(14, 14, 14, 0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          boxShadow: [
            BoxShadow(color: Color(0xffE4E4E4), blurRadius: 3, spreadRadius: 2)
          ]),
      child: Material(
        color: Colors.white,
        child: InkWell(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image(
                          width: 66,
                          height: 66,
                          image: AssetImage(
                              'images/product_images/${list[index].productImage}'),
                        ),
                        SizedBox(
                          width: 11,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              list[index].productName,
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[800]),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              NumberFormat.currency(symbol: '₵')
                                  .format(list[index].productPrice),
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor),
                            )
                          ],
                        )
                      ],
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        remove;
                      },
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      label: Text(
                        'REMOVE',
                        style: TextStyle(color: Colors.red),
                      ),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.transparent),
                          elevation: MaterialStatePropertyAll(0),
                          overlayColor:
                              MaterialStatePropertyAll(Colors.red[100])),
                    ),
                  ],
                ),
                Column(
                  children: [
                    //The increment button
                    gradientButton(increase, '+'),
                    SizedBox(
                      height: 7,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 9, vertical: 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                          border: Border.all(
                            width: 1,
                          )),
                      child: Text(
                        itemQuantity.toString(),
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 7,
                    ),

                    //The decrement button
                    gradientButton(decrease, '-'),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  gradientButton(void Function()? method, String symbol) {
    return InkWell(
      onTap: method,
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(6)),
            gradient: LinearGradient(
                colors: [Color(0xff95C6DA), Color(0xff459ABE)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)),
        child: Center(
          child: Text(
            symbol,
            style: TextStyle(fontSize: 15, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
