import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techwise_pub/Views/Components/cart_item_layout.dart';
import 'package:techwise_pub/Views/Components/layouts.dart';
import 'package:techwise_pub/methods.dart';
import 'package:techwise_pub/services/data_services.dart';
import '../../Models/product_info.dart';

import '../../Models/user_properties.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {

  Layouts layouts = Layouts();
  double promoDiscount = 0.0;
  final dataInstance = DataServices();

  double cartTotal(List<ProductProperties> list) {
    double total = 0;
    list.forEach((element) {
      total += element.price * element.orderQuantity!;
    });
    return total;
  }
  double delivery(int listLength) {
    return 10.0 * listLength;
  }
  double subtotal(double cartTotal, double delivery,){
    return cartTotal + delivery + promoDiscount;
  }

  @override
  Widget build(BuildContext context) {

    final textTheme = Theme.of(context).textTheme;
    final user = Provider.of<UserProperties?>(context);

    Widget cartLayout({required List<ProductProperties> products}) {
      return Column(
        children: [
          Expanded(
            // flex: 4,
            child: ListView.builder(
              itemCount: products.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final item = products[index];
                return CartItemLayout(
                    increase: item.orderQuantity! >= item.Quantity ? null : () async {
                      await dataInstance.updateOrderQuantity(item.orderQuantity! + 1, user!.uid, item.productId);
                    },
                    decrease:item.orderQuantity! <= 1 ? null : () async {
                      await dataInstance.updateOrderQuantity(item.orderQuantity! - 1, user!.uid, item.productId);
                    },
                    product: products[index],
                    remove: () {},
                );
              },
            ),
          ),
          SizedBox(
            height: 17,
          ),
          Container(
              padding: EdgeInsets.all(9),
              margin: EdgeInsets.only(right: 25, left: 25),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  boxShadow: [
                    BoxShadow(
                        color: Color(0xffE4E4E4),
                        blurRadius: 3,
                        spreadRadius: 2)
                  ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: TextFormField(
                    decoration: InputDecoration(
                        hintText: 'Promo Code here...',
                        enabledBorder: InputBorder.none),
                  )),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      'Apply',
                      style: textTheme.labelSmall,
                    ),
                    style: ButtonStyle(elevation: MaterialStatePropertyAll(0)),
                  )
                ],
              )),
          SizedBox(height: 30,),
          //The calculation summary
          Container(
            margin: EdgeInsets.only(right: 26, left: 26),
            child: Column(
              children: [
                //Cart total
                annotations(heading: 'Cart total', value: cartTotal(products)),
                const SizedBox(
                  height: 20,
                ),
                //Delivery
                annotations(
                    heading: 'Delivery', value: delivery(products.length)),
                const SizedBox(
                  height: 20,
                ),
                //Promo Discount
                annotations(heading: 'Promo Discount', value: promoDiscount),
                Divider(
                  thickness: 1,
                  color: Colors.grey[600],
                  height: 20,
                ),
                annotations(
                    heading: 'Subtotal', value: subtotal(cartTotal(products), delivery(products.length)), isTotal: true),
              ],
            ),
          ),
          SizedBox(
            height: 39,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/checkout',
                  arguments: {'total': subtotal});
            },
            child: Text(
              'PROCEED TO CHECKOUT',
              style: textTheme.labelMedium,
            ),
          )
        ],
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Cart',
          ),
          // actions: [
          //   Center(
          //       child: Padding(
          //     padding: const EdgeInsets.only(right: 8.0),
          //     child: Text(
          //       p.length.toString(),
          //       style: TextStyle(
          //         fontWeight: FontWeight.bold,
          //       ),
          //     ),
          //   ))
          // ],
        ),
        body: StreamBuilder(
          stream: dataInstance.getCartOrWishlistData(user!.uid, true),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasData) {
              if (snapshot.data == null) {
                return Center(
                  child: layouts.emptyPage('No item added to cart'),
                );
              } else {
                List<ProductProperties> cartProducts = [];
                for (var data in snapshot.data!.docs) {
                  cartProducts.add(ProductProperties(
                    productId: data.id,
                    name: data['name'],
                    numOfReviews: data['numOfReviews'],
                    price: data['price'],
                    totalRating: data['totalRating'],
                    imageUrl: data['imageUrl'].toList(),
                    keyProperties: data['keyProperties'],
                    description: data['description'],
                    category: data['category'],
                    subCategory: data['subCategory'],
                    Quantity: data['Quantity'],
                    orderQuantity: data['orderQuantity']
                  ));
                }
                return cartLayout(products: cartProducts);
              }
            } else {
              return Center(
                child: layouts.emptyPage('Couldn\'t retrieve data!'),
              );
            }
          },
        ));
  }

  Widget annotations(
      {required String heading, required double value, bool? isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          heading,
          style: TextStyle(
            fontSize: 15,
            color: isTotal! ? const Color(0xff0074A6) : Colors.grey[600],
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          currency(value),
          style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: isTotal ? const Color(0xff0074A6) : null),
        )
      ],
    );
  }
}
