import 'package:flutter/material.dart';
import 'package:techwise_pub/Views/Components/cart_item_layout.dart';
import 'package:techwise_pub/Views/Components/layouts.dart';
import '../../Models/product_info.dart';
import 'package:intl/intl.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  List<ProductInfo> cartProduct = [
    ProductInfo(
        productName: 'Dell G16 gaming laptop',
        productPrice: 28999,
        productRating: 0,
        productDescription: 'powerful gaming laptop',
        productCategory: 'Laptops',
        addedToCart: false,
        addedToFavorite: false,
        numReview: 0,
        productImage: 'dell_gaming_laptop.jpg'),
    ProductInfo(
        productName: 'Alienware m15 gaming laptop',
        productPrice: 37295,
        productRating: 0,
        productDescription: 'powerful gaming laptop',
        productCategory: 'Laptops',
        addedToCart: false,
        addedToFavorite: false,
        numReview: 0,
        productImage: 'alienware_m15.jpg'),
    ProductInfo(
        productName: 'Alienware m15 gaming laptop',
        productPrice: 37295,
        productRating: 0,
        productDescription: 'powerful gaming laptop',
        productCategory: 'Laptops',
        addedToCart: false,
        addedToFavorite: false,
        numReview: 0,
        productImage: 'alienware_m15.jpg'),
  ];
  Layouts layouts = Layouts();

  late double delivery;
  late double subtotal;
  double promoDiscount = 0.0;

  cartTotal() {
    double total = 0;
    for (int i = 0; i < cartProduct.length; i++) {
      total += (cartProduct[i].productPrice * cartProduct[i].numOfOrder);
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    delivery = (20 * cartProduct.length.toDouble());
    subtotal = cartTotal() + delivery + promoDiscount;
    final textTheme = Theme.of(context).textTheme;

    Widget cartLayout() {
      return Column(
        children: [
          Flexible(
            flex: 4,
            child: ListView.builder(
              itemCount: cartProduct.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return CartItemLayout(
                    index: index,
                    increase: () {
                      setState(() {
                        cartProduct[index].increaseNumOfOrder();
                      });
                    },
                    decrease: () {
                      setState(() {
                        cartProduct[index].decreaseNumOfOrder();
                      });
                    },
                    list: cartProduct,
                    remove: () {
                      setState(() {
                        cartProduct.removeAt(index);
                      });
                    });
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
          Spacer(),
          //The calculation summary
          Container(
            margin: EdgeInsets.only(right: 26, left: 26),
            child: Column(
              children: [
                //Cart total
                annotations(heading: 'Cart total', value: cartTotal()),
                const SizedBox(
                  height: 20,
                ),
                //Delivery
                annotations(heading: 'Delivery', value: delivery),
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
                    heading: 'Subtotal', value: subtotal, isTotal: true),
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
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          title: const Text(
            'Cart',
          ),
          actions: [
            Center(
                child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Text(
                cartProduct.length.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ))
          ],
        ),
        body: cartProduct.isEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  layouts.emptyPage('No product added to your cart'),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    child: Text('Start shopping'),
                    onPressed: () {
                      Navigator.popUntil(context, ModalRoute.withName('/home'));
                    },
                  )
                ],
              )
            : cartLayout());
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
          NumberFormat.currency(symbol: '₵').format(value),
          style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: isTotal ? const Color(0xff0074A6) : null),
        )
      ],
    );
  }
}
