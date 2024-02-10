import 'product_info.dart';

class AllProducts{
  List<ProductInfo> productInfo = [
    ProductInfo(productName: 'Dell G16 gaming laptop', productPrice: 28999, productRating: 0, productDescription: 'powerful gaming laptop', productCategory: 'Laptops', addedToCart: false, addedToFavorite: false, numReview: 0, productImage: 'dell_gaming_laptop.jpg'),
    ProductInfo(productName: '2021 Apple macbook pro', productPrice: 29999, productRating: 0, productDescription: 'Powerful Apple laptop', productCategory: 'Laptops', addedToCart: false, addedToFavorite: false, numReview: 0, productImage: 'macbook_pro.jpg'),
    ProductInfo(productName: 'Acer Aspire Predator', productPrice: 40000, productRating: 0, productDescription: 'Best Acer gaming computer', productCategory: 'Pc Gaming', addedToCart: false, addedToFavorite: false, numReview: 0, productImage: 'acer_predator.jpg'),
    ProductInfo(
        productName: 'Alienware m15 gaming laptop',
        productPrice: 37295,
        productRating: 0,
        productDescription: 'powerful gaming laptop',
        productCategory: 'Laptops',
        addedToCart: false,
        addedToFavorite: false,
        numReview: 0,
        productImage: 'alienware_m15.jpg'),
  ];
  List<ProductInfo> cartProduct = [];
  List<ProductInfo> favoriteProduct = [];
}