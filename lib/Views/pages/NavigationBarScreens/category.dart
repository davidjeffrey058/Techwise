import 'package:flutter/material.dart';
import 'package:techwise_pub/Models/product_category.dart';

class Category extends StatefulWidget {
  const Category({Key? key}) : super(key: key);

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  List<ProductCategory> productCategory = [
    ProductCategory(catName: 'Laptops', catPic: 'laptop.png'),
    ProductCategory(catName: 'Desktops', catPic: 'desktop.png'),
    ProductCategory(catName: 'Pc Gaming', catPic: 'pc_gaming.png'),
    ProductCategory(catName: 'Monitors', catPic: 'monitor.png'),
    ProductCategory(catName: 'Computer Components', catPic: 'processor.jpg'),
    ProductCategory(catName: 'Tablets \& Phones', catPic: 'tablet.png'),
    ProductCategory(
        catName: 'Computer Accessories', catPic: 'keyboard_mouse.png'),
    ProductCategory(catName: 'Storage \& Hardrives', catPic: 'hard_drive.png'),
    ProductCategory(catName: 'Networking', catPic: 'moderm.png'),
  ];

  @override
  Widget build(BuildContext context) {
    layout(int axisCount) {
      return GridView.builder(
        key: PageStorageKey('category-grid'),
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: axisCount,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20),
        itemCount: productCategory.length,
        itemBuilder: (BuildContext context, int index) {
          return Material(
            clipBehavior: Clip.hardEdge,
            elevation: 2,
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/product_category',
                    arguments: {'category': productCategory[index].catName});
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image(
                      height: 69,
                      width: 96,
                      image: AssetImage(
                          'images/category_images/${productCategory[index].catPic}'),
                    ),
                    const SizedBox(
                      height: 11,
                    ),
                    Text(productCategory[index].catName,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.displayMedium)
                  ],
                ),
              ),
            ),
          );
        },
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Category',
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
        ),
        body: OrientationBuilder(
          builder: (BuildContext context, Orientation orientation) {
            return orientation == Orientation.portrait ? layout(2) : layout(4);
          },
        ));
  }
}
