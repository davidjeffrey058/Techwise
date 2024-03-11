import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:techwise_pub/Views/Components/custom_icon.dart';
import '../../../Models/product_info.dart';
import '../../../methods.dart';

class HomeProductLayout extends StatelessWidget {
  final List<ProductProperties> product;
  final String pageStorageKeyValue;
  const HomeProductLayout(
      {super.key, required this.product, required this.pageStorageKeyValue,});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        key: PageStorageKey(pageStorageKeyValue),
        scrollDirection: Axis.horizontal,
        child: Row(
            children: product.map((e) {
          return InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/product_page', arguments: {
                'product': e,
              });
            },
            child: Container(
              child: SizedBox(
                width: 171,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 8,
                    ),
                    // Product image container
                    Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xffE4E4E4),
                              spreadRadius: 2,
                              blurRadius: 3,
                              offset: Offset(0, 3),
                            ),
                          ]),
                      height: 130,
                      width: 153,
                      child: Image.network(
                        e.imageUrl.first,
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
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 8, 8, 2),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              e.name,
                              style: const TextStyle(
                                fontSize: 12,
                              ),
                              maxLines: 1,
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          FavoriteIcon(
                            productId: e.productId,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              NumberFormat.currency(locale: 'en_US')
                                  .format(e.price),
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                          ),
                          Text('${rating(e.totalRating, e.numOfReviews)}'),
                          const Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 15,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        }).toList()));
  }
}
