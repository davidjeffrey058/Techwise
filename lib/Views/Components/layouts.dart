import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Layouts {
  //Layouts for special products in home tab

  //Grid layout for the category page
  Widget categoryProduct(index, context, prudt) {
    return GestureDetector(
      onTap: () {
        // Navigator.pushNamed(context, '/product_page', arguments: {
        //   'product_image': prudt[index].productImage,
        //   'product_name': prudt[index].productName,
        //   'product_price': prudt[index].productPrice,
        //   'product_rating': prudt[index].productRating,
        //   'num_review': prudt[index].numReview,
        //   'added_to_favorite': prudt[index].addedToFavorite,
        //   'product_description': prudt[index].productDescription
        // });
      },
      child: Card(
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image(
                  fit: BoxFit.cover,
                  height: 100,
                  image: AssetImage(
                      'images/product_images/${prudt[index].productImage}')),
              Text(
                prudt[index].productName,
                style: const TextStyle(fontSize: 12),
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      NumberFormat.currency(symbol: '₵')
                          .format(prudt[index].productPrice),
                      style: const TextStyle(
                          color: Color(0xff0074A6),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(prudt[index].productRating.toString()),
                  const Icon(
                    Icons.star,
                    size: 15,
                    color: Colors.yellow,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

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
