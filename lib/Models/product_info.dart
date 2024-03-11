
class ProductInfo{
  String productName;
  double productPrice;
  double productRating;
  String productDescription;
  String productImage;
  int numReview;
  String productCategory;
  bool addedToFavorite;
  bool addedToCart;
  int numOfOrder = 1;

  ProductInfo({required this.productName, required this.productPrice, required this.productRating,
  required this.productDescription, required this.productCategory, required this.addedToCart, required this.addedToFavorite,
  required this.numReview, required this.productImage,});

  addToFavorite(value){
    addedToFavorite = !value;
    return addedToFavorite;
  }
  addToCart(value){
    addedToCart = !value;
    return addedToCart;
  }
  increaseNumOfOrder(){
    if(numOfOrder > 0){
      numOfOrder++;
    }
  }
  decreaseNumOfOrder(){
    if(numOfOrder > 1){
      numOfOrder--;
    }
  }
}

class ProductProperties{
  String productId;
  String name;
  double price;
  int numOfReviews;
  int totalRating;
  String description;
  List imageUrl;
  String category;
  String? subCategory;
  Map<String, dynamic> keyProperties;
  int Quantity;
  int? orderQuantity;

  ProductProperties({
    required this.name,
    required this.price,
    required this.numOfReviews,
    required this.totalRating,
    required this.description,
    required this.imageUrl,
    required this.category,
    this.subCategory,
    required this.keyProperties,
    required this.Quantity,
    required this.productId,
    this.orderQuantity
});
}