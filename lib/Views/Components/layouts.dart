import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:techwise_pub/Models/product_info.dart';
// import 'package:techwise_pub/methods.dart';

class Layouts {
  //Layouts for special products in home tab

  //Grid layout for the category page
  // Widget categoryProduct(int index, BuildContext context, ProductProperties item) {
  //   return GestureDetector(
  //     onTap: () {
  //       Navigator.of(context).pushNamed('/product_page', arguments: { "product" : item});
  //     },
  //     child: Card(
  //       elevation: 3,
  //       child: Padding(
  //         padding: const EdgeInsets.all(8.0),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.stretch,
  //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //           children: [
  //             Image(
  //                 fit: BoxFit.cover,
  //                 height: 100,
  //                 image: NetworkImage(item.imageUrl.first),
  //             ),
  //             Text(
  //               item.name,
  //               style: const TextStyle(fontSize: 12),
  //             ),
  //             Row(
  //               children: [
  //                 Expanded(
  //                   child: Text(
  //                     NumberFormat.currency(symbol: '\$')
  //                         .format(item.price),
  //                     style: const TextStyle(
  //                         color: Color(0xff0074A6),
  //                         fontWeight: FontWeight.bold),
  //                   ),
  //                 ),
  //                 Text(
  //                   '${rating(item.totalRating, item.numOfReviews)}'
  //                 ),
  //                 const Icon(
  //                   Icons.star,
  //                   size: 15,
  //                   color: Colors.yellow,
  //                 )
  //               ],
  //             )
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  //A layout to display an empty message when a page is empty
  Widget emptyPage(String message) {
    return Center(
      child: Text(
        message,
        style: const TextStyle(
            fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black26),
      ),
    );
  }
}
