import 'package:flutter/material.dart';
import 'package:techwise_pub/Views/Components/home_components/special_product_section.dart';
import 'package:techwise_pub/Views/Components/home_components/title_section.dart';
import 'package:techwise_pub/Views/Components/product_loading.dart';
import 'package:techwise_pub/services/data_services.dart';
import 'package:techwise_pub/Models/all_products.dart';
import 'package:techwise_pub/Models/product_info.dart';
import 'package:techwise_pub/Views/Components/home_components/home_product_layout.dart';
import 'package:techwise_pub/color_palette.dart';

class HomeTab extends StatefulWidget {
  final String title;
  const HomeTab({Key? key, required this.title}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

late PageController pageController;

class _HomeTabState extends State<HomeTab> {
  final AllProducts _allProducts = AllProducts();
  ColorPalette colorPalette = ColorPalette();
  int currentIndex = 0;
  DataServices dataServices = DataServices();
  late Future<List<ProductProperties>?> dataInstance;

  @override
  void initState() {
    super.initState();
    dataInstance = dataServices.getData();
    pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    // final productFeatures = Provider.of<ProductProperties?>(context);

    var productInfoList = _allProducts.productInfo;

    return Scaffold(
      body: Column(
        children: [
          TitleSection(title: widget.title),
          Flexible(
            child: ListView(
              key: PageStorageKey('home-main'),
              shrinkWrap: true,
              children: [
                // PageView layout
                SpecialProductSection(
                  key: PageStorageKey('home-pageview'),
                  productInfoList: productInfoList,
                  onPageChanged: (index) =>
                      setState(() => currentIndex = index),
                  pageController: pageController,
                  next: () => pageController.nextPage(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeIn),
                  previous: () => pageController.previousPage(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeIn),
                ),
                sectionText('Popular Products'),
                FutureBuilder(
                  future: dataInstance,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return SizedBox(
                        height: 200,
                        child: ListView.builder(
                          key: PageStorageKey('popular'),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: 5,
                          itemBuilder: (context, index){
                            return  ProductLoading();
                          },
                        ),
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.done) {
                      // print(snapshot.data?[0].imageUrl);
                      return HomeProductLayout(
                        product: snapshot.data!,
                        pageStorageKeyValue: 'popular',
                      );
                    } else {
                      return Center(
                        child: Text(
                          'Couldn\'t load data',
                          style: TextStyle(fontSize: 20),
                        ),
                      );
                    }
                  },
                ),
                sectionText('Featured Products'),
                FutureBuilder(
                  future: dataInstance,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return SizedBox(
                        height: 200,
                        child: ListView.builder(
                          key: PageStorageKey('featured'),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: 5,
                          itemBuilder: (context, index){
                            return  ProductLoading();
                          },
                        ),
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.done) {
                      // print(snapshot.data?[0].imageUrl);
                      return HomeProductLayout(
                        product: snapshot.data!,
                        pageStorageKeyValue: 'featured',
                      );
                    } else {
                      return Center(
                        child: Text(
                          'Couldn\'t load data',
                          style: TextStyle(fontSize: 20),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildIndicator(bool isSelected) {
    return Container(
      height: isSelected ? 12 : 8,
      decoration: BoxDecoration(
          color: isSelected ? Theme.of(context).primaryColor : Colors.grey,
          shape: BoxShape.circle),
    );
  }

  Widget sectionText(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, top: 4, bottom: 4),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.start,
      ),
    );
  }
}
