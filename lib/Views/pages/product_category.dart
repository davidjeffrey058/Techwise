import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:techwise_pub/Models/all_products.dart';
import 'package:techwise_pub/Models/product_info.dart';
import 'package:techwise_pub/Views/Components/layouts.dart';

class ProductCategoryPage extends StatefulWidget {
  const ProductCategoryPage({Key? key}) : super(key: key);

  @override
  State<ProductCategoryPage> createState() => _ProductCategoryPageState();
}

class _ProductCategoryPageState extends State<ProductCategoryPage> {
  dynamic contents = {};
  AllProducts allProducts = AllProducts();
  List<ProductInfo> prudt = [];
  Layouts layouts = Layouts();
  late Widget whatLayout = Grid();

  @override
  Widget build(BuildContext context) {
    contents = ModalRoute.of(context)?.settings.arguments;
    int i = 0;
    prudt.clear();
    while (i < allProducts.productInfo.length) {
      if (allProducts.productInfo[i].productCategory
          .contains(contents['category'])) {
        prudt.add(allProducts.productInfo[i]);
      }
      i++;
    }
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          contents['category'],
          style: const TextStyle(fontSize: 15),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
            tooltip: 'Search',
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/cart');
            },
            icon: const Icon(Icons.shopping_cart),
            tooltip: 'Cart',
          ),
        ],
      ),
      body: prudt.isEmpty
          ? layouts.emptyPage('No item in this category')
          : Column(
              children: [
                gridAndLinear(),
                whatLayout,
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xff0074A6),
        tooltip: 'Filter',
        child: const Icon(Icons.filter_alt),
      ),
    );
  }

  gridAndLinear() {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
            tooltip: 'Grid View',
            splashRadius: 20,
            onPressed: () {
              setState(() {
                whatLayout = Grid();
              });
            },
            icon: Icon(Icons.grid_view),
          ),
          IconButton(
            tooltip: 'List View',
            splashRadius: 20,
            onPressed: () {
              setState(() {
                whatLayout = linear();
              });
            },
            icon: Icon(Icons.list),
          )
        ],
      ),
    );
  }

  Widget Grid() {
    return Flexible(
      child: GridView.builder(
        shrinkWrap: true,
        itemCount: prudt.length,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          //Returning a Widget inside the Layout class
          return layouts.categoryProduct(index, context, prudt);
        },
      ),
    );
  }

  Widget linear() {
    return Expanded(
      child: ListView.builder(
        itemCount: prudt.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(11.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                                'images/product_images/${prudt[index].productImage}'),
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        boxShadow: [
                          BoxShadow(
                              color: Color(0xffE4E4E4),
                              spreadRadius: 1,
                              blurRadius: 3,
                              offset: Offset(0, 2))
                        ]),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      Text(prudt[index].productName,
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[800])),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        NumberFormat.currency(symbol: '₵')
                            .format(prudt[index].productPrice),
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(prudt[index].productRating.toString()),
                          const Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 15,
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
