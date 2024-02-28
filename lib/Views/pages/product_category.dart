import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:techwise_pub/Models/product_info.dart';
import 'package:techwise_pub/Views/Components/layouts.dart';
import 'package:techwise_pub/services/data_services.dart';
import '../../methods.dart';

class ProductCategoryPage extends StatefulWidget {
  const ProductCategoryPage({Key? key}) : super(key: key);

  @override
  State<ProductCategoryPage> createState() => _ProductCategoryPageState();
}

dynamic contents = {};
Layouts layouts = Layouts();
late bool isGrid;

class _ProductCategoryPageState extends State<ProductCategoryPage> {
  @override
  void initState() {
    super.initState();
    isGrid = true;
  }

  @override
  Widget build(BuildContext context) {
    contents = ModalRoute.of(context)?.settings.arguments;
    return Scaffold(
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
      body: FutureBuilder(
        future: DataServices().getCategoryData(contents['category']),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasData) {
            if (snapshot.data!.isNotEmpty) {
              return Column(
                children: [
                  gridAndLinear(),
                  isGrid
                      ? Grid(
                          itemCount: snapshot.data!.length,
                          product: snapshot.data!)
                      : linear(
                          itemCount: snapshot.data!.length,
                          product: snapshot.data!)
                ],
              );
            } else {
              return layouts.emptyPage('No data');
            }
          } else {
            return layouts.emptyPage('An error occurred');
          }
        },
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
            onPressed: () => setState(() => isGrid = true),
            icon: Icon(Icons.grid_view),
            style: ButtonStyle(
                backgroundColor: isGrid
                    ? MaterialStatePropertyAll(
                        Theme.of(context).primaryColor.withOpacity(0.2))
                    : null),
          ),
          IconButton(
            tooltip: 'List View',
            splashRadius: 20,
            onPressed: () => setState(() => isGrid = false),
            icon: Icon(Icons.list),
            style: ButtonStyle(
                backgroundColor: !isGrid
                    ? MaterialStatePropertyAll(
                        Theme.of(context).primaryColor.withOpacity(0.2))
                    : null),
          )
        ],
      ),
    );
  }

  Widget Grid(
      {required int itemCount, required List<ProductProperties> product}) {
    return Flexible(
      child: GridView.builder(
        shrinkWrap: true,
        itemCount: itemCount,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          ProductProperties item = product[index];
          return layouts.categoryProduct(index, context, item);
        },
      ),
    );
  }

  Widget linear(
      {required int itemCount, required List<ProductProperties> product}) {
    return Expanded(
      child: ListView.builder(
        itemCount: itemCount,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          ProductProperties item = product[index];
          return Card(
            clipBehavior: Clip.hardEdge,
            child: InkWell(
              onTap: () {
                Navigator.of(context).pushNamed('/product_page', arguments: { "product" : product[index]});
              },
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
                              image: NetworkImage(item.imageUrl.first),
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
                        Text(item.name,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[800])),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          NumberFormat.currency(symbol: '\$').format(item.price),
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
                            Text(
                                '${rating(item.totalRating, item.numOfReviews)}'),
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
            ),
          );
        },
      ),
    );
  }
}
