import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:techwise_pub/Models/product_info.dart';
import 'package:techwise_pub/Views/Components/carousel_layout.dart';
import 'package:techwise_pub/methods.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  dynamic data = {};
  // Future getUrl() async{
  //
  //   List urls = [];
  //
  //   final instance = FirebaseStorage.instance.ref();
  //   var res = await instance.child('products/techwis-laptop-0002/').list();
  //   for(var items in res.items){
  //     urls.add(await items.getDownloadURL());
  //   }
  //   print(urls);
  // }


  late ProductProperties product;

  @override
  Widget build(BuildContext context) {
    // getUrl();
    data = ModalRoute.of(context)?.settings.arguments;
   product = data['product'];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Details',
          style: TextStyle(fontSize: 15),
        ),
        actions: [
          IconButton(
            icon: data['hide'] == null
                ? Icon(Icons.shopping_cart)
                : SizedBox(
                    width: 0,
                  ),
            onPressed: data['hide'] == null
                ? () => Navigator.pushNamed(context, '/cart')
                : null,
          )
        ],
      ),
      body: Column(children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      CarouselSlider(
                          options: CarouselOptions(
                              autoPlay: true,
                              autoPlayInterval: Duration(seconds: 3),
                              aspectRatio: 16 / 9,
                              enlargeCenterPage: true),
                          items: product.imageUrl
                              .map((e) => InkWell(
                                  onTap: () => Navigator.pushNamed(
                                          context, '/image_viewer',
                                          arguments: {
                                            'picture': product.imageUrl,
                                          }),
                                  child: CarouselLayout(value: e)))
                              .toList()),
                      Container(
                        padding: const EdgeInsets.fromLTRB(15, 12, 15, 0),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    product.name,
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xff707070)),
                                  ),
                                ),
                                Icon(
                                  Icons.favorite_border,
                                  color: Colors.red,
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              NumberFormat.currency(locale: 'en_US')
                                  .format(product.price),
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff0074A6)),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Row(
                              children: [
                                Text(
                                  '${rating(product.totalRating, product.numOfReviews)}',
                                ),
                                const Icon(
                                  Icons.star,
                                  size: 15,
                                  color: Colors.yellow,
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                Text(
                                    '(${product.numOfReviews} Reviews)')
                              ],
                            ),
                            const SizedBox(
                              height: 21,
                            ),
                            const Text(
                              'Description',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff707070)),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              product.description,
                              style: const TextStyle(fontSize: 12),
                              textAlign: TextAlign.justify,
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            Text(
                              'Product Properties',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff707070)),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            //Displays a table for the product properties
                            ListView.builder(
                              primary: false,
                              shrinkWrap: true,
                              itemCount: product.keyProperties.length,
                              itemBuilder: (context, index) {
                                var property = product.keyProperties
                                    .values
                                    .toList()[index];
                                var propertyName = product.keyProperties
                                    .keys
                                    .toList()[index];
                                return Table(
                                  // border: TableBorder.all(),
                                  children: [
                                    TableRow(children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            color: Colors.grey[400],
                                            border: BorderDirectional(
                                                bottom: BorderSide(
                                                    color: Colors.white))),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            '${propertyName}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            color: Colors.grey[200],
                                            border: BorderDirectional(
                                                bottom: BorderSide(
                                                    color: Colors.white))),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text('${property}'),
                                        ),
                                      )
                                    ])
                                  ],
                                );
                              },
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            Text(
                              'Rate this product',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff707070)),
                            ),
                            SizedBox(
                              height: 10,
                            ),

                            SizedBox(
                              height: 80,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(top: 11, bottom: 11),
          decoration: const BoxDecoration(boxShadow: [
            BoxShadow(
                color: Colors.black26,
                spreadRadius: 1,
                blurRadius: 2,
                offset: Offset(0, -2))
          ], color: Colors.white),
          child: Center(
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.shopping_cart_outlined),
              label: Text(
                'ADD TO CART',
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ),
          ),
        )
      ]),
    );
  }
}
