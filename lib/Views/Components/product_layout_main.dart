import 'package:flutter/material.dart';
import 'package:techwise_pub/Models/product_info.dart';
import 'package:techwise_pub/Views/Components/custom_icon.dart';
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
                  Container(
                    color: Colors.grey[200],
                    height: 150,
                    width: double.infinity,
                    child:Image.network(
                     product.imageUrl.first,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress){
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null ?
                            loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes! : null,
                          ),
                        );
                      },
                      errorBuilder: (context,error, stackTrace){
                        return Icon(Icons.image, size: 50, color: Colors.white,);
                      },
                    ),
                  ),
                  Positioned(
                    top: 5,
                    right: 5,
                    child: FavoriteIcon(isIconButton: true, productId: product.productId,)
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
