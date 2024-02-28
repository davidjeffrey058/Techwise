import 'package:flutter/material.dart';
import 'package:techwise_pub/Models/product_info.dart';
import 'package:techwise_pub/methods.dart';

class ProductLayoutMain extends StatelessWidget {
  final ProductProperties product;

  ProductLayoutMain({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: product.name,
      child: Material(
        clipBehavior: Clip.hardEdge,
        elevation: 1,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          onTap: () => Navigator.pushNamed(context, '/product_page',
              arguments: {"product": product}),
          child: Column(
            children: [
              Stack(
                children: [
                  Material(
                    color: Colors.grey.shade300,
                    child: Image(
                      height: 150,
                      width: double.infinity,
                      image: NetworkImage(product.imageUrl.first),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 5,
                    right: 5,
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.favorite_border_rounded,
                        color: Colors.red,
                      ),
                      style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(Colors.white),
                          elevation: MaterialStatePropertyAll(2)),
                    ),
                  )
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        product.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800],
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            currency(product.price),
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor),
                          ),
                          Spacer(),
                          Text(
                              '${rating(product.totalRating, product.numOfReviews)}'),
                          Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 15,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
