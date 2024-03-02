import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techwise_pub/Models/product_info.dart';
import 'package:techwise_pub/Models/user_properties.dart';
import 'package:techwise_pub/Views/Components/layouts.dart';
import 'package:techwise_pub/methods.dart';
import 'package:techwise_pub/services/data_services.dart';

class WishList extends StatefulWidget {
  const WishList({Key? key}) : super(key: key);

  @override
  State<WishList> createState() => _WishListState();
}

class _WishListState extends State<WishList> {
  Layouts layouts = Layouts();
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProperties>(context);

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
        body: StreamBuilder(
          stream: DataServices().getCartOrWishlistData(user.uid, false),
          builder: (context, snapshot) {

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            else if (snapshot.hasData) {
              List<ProductProperties> wishlistProducts = [];
              for(var data in snapshot.data!.docs){
                wishlistProducts.add(ProductProperties(
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
                ));
              }
              return Padding(
                padding: EdgeInsets.fromLTRB(11, 11, 11, 0),
                child: ListView.builder(
                  itemCount: wishlistProducts.length,
                  itemBuilder: (context, index){
                    return cartLayout(product: wishlistProducts[index]);
                  },
                ),
              );
            } else {
              return layouts.emptyPage('Sign in to access wishlist');
            }
          },
        ));
  }

  Widget cartLayout(
      {required ProductProperties product}) {
    return Material(
      clipBehavior: Clip.hardEdge,
      borderRadius: BorderRadius.circular(10),
      elevation: 1,
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, '/product_page', arguments: { "product" : product }),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Image(height: 66, width: 66, image: NetworkImage(product.imageUrl.first)),
                  SizedBox(
                    width: 10,
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
              SizedBox(
                height: 13,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {},
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
                        overlayColor: MaterialStatePropertyAll(Colors.red[100])),
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
      ),
    );
  }
}
