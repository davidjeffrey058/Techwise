import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:techwise_pub/Models/product_info.dart';
import 'package:techwise_pub/Views/Components/layouts.dart';

class WishList extends StatefulWidget {
  const WishList({Key? key}) : super(key: key);

  @override
  State<WishList> createState() => _WishListState();
}

class _WishListState extends State<WishList> {
  List<ProductInfo> wishlist = [
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Wishlist',
          style: TextStyle(fontSize: 15),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/cart');
            },
            icon: const Icon(Icons.shopping_cart),
          )
        ],
        // backgroundColor: Colors.red,
        elevation: 0,
      ),
      body: wishlist.isEmpty
          ? layouts.emptyPage('No saved item')
          : linearLayout(),
    );
  }

  linearLayout() {
    return ListView.builder(
      itemCount: wishlist.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            // Navigator.pushNamed(context, '/product_page', arguments: {
            //   'product_image': wishlist[index].productImage,
            //   'product_name': wishlist[index].productName,
            //   'product_price': wishlist[index].productPrice,
            //   'product_rating': wishlist[index].productRating,
            //   'num_review': wishlist[index].numReview,
            //   'added_to_favorite': wishlist[index].addedToFavorite,
            //   'product_description': wishlist[index].productDescription
            // });
          },
          child: Container(
            margin: EdgeInsets.fromLTRB(11, 11, 11, 0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(8)),
                boxShadow: [
                  BoxShadow(
                      color: Color(0xffE4E4E4),
                      blurRadius: 3,
                      spreadRadius: 1,
                      offset: Offset(0, 3))
                ]),
            padding: EdgeInsets.symmetric(vertical: 7, horizontal: 9),
            child: Column(
              children: [
                Row(
                  children: [
                    Image(
                      height: 66,
                      width: 66,
                      image: AssetImage(
                          'images/product_images/${wishlist[index].productImage}'),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          wishlist[index].productName,
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
                              .format(wishlist[index].productPrice),
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor),
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 13,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          wishlist.removeAt(index);
                        });
                      },
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      label: Text(
                        'REMOVE',
                        style: Theme.of(context)
                            .textTheme
                            .labelSmall
                            ?.copyWith(color: Colors.red),
                      ),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.transparent),
                          elevation: MaterialStatePropertyAll(0),
                          overlayColor:
                              MaterialStatePropertyAll(Colors.red[100])),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        'ADD TO CART',
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
