import 'package:flutter/material.dart';
import 'package:techwise_pub/Models/product_info.dart';
import 'package:techwise_pub/methods.dart';

class CartItemLayout extends StatelessWidget {
  final Function()? increase;
  final Function()? decrease;
  final Function()? remove;
  final ProductProperties product;

  const CartItemLayout(
      {super.key,
      this.increase,
      this.decrease,
      this.remove,
      required this.product});

  @override
  Widget build(BuildContext context) {
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
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () => Navigator.pushNamed(context, '/product_page',
                        arguments: {"product": product, "hide": true}),
                    child: Row(
                      children: [
                        Container(
                          width: 66,
                          height: 66,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            image: DecorationImage(
                              image: NetworkImage(product.imageUrl.first),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 11,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.name,
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[800]),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              currency(product.price),
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor),
                            )
                          ],
                        )
                      ],
                    ),
                  ),

                  // Remove cart item button
                  ElevatedButton.icon(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Confirm Removal'),
                              content: Text(
                                  'Do you want to remove this product from your wishlist?'),
                              actions: [
                                OutlinedButton(
                                    onPressed: remove,
                                    child: Text(
                                      'Remove',
                                      style: TextStyle(color: Colors.red),
                                    )),
                                OutlinedButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                    child: Text('Cancel')),
                              ],
                            );
                          });
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
                  gradientButton(
                      increase, '+', product.orderQuantity!, product.Quantity),
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
                      product.orderQuantity.toString(),
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  gradientButton(
                      decrease, '-', product.orderQuantity!, product.Quantity),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  gradientButton(void Function()? method, String symbol, int orderQuantity,
      int productQuantity) {
    List<Color> colorList;
    if (symbol == '-') {
      colorList = orderQuantity <= 1
          ? [
              Colors.grey.shade200,
              Colors.grey,
            ]
          : [Color(0xff95C6DA), Color(0xff459ABE)];
    } else {
      colorList = orderQuantity >= productQuantity
          ? [
              Colors.grey.shade200,
              Colors.grey,
            ]
          : [Color(0xff95C6DA), Color(0xff459ABE)];
    }
    return InkWell(
      onTap: method,
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(6)),
            gradient: LinearGradient(
                colors: colorList,
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
