import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:techwise_pub/Models/product_info.dart';

class DataServices {
  final docRef = FirebaseFirestore.instance.collection('products');
  final userRef = FirebaseFirestore.instance.collection('Users');
  final instance = FirebaseStorage.instance.ref();

  // AuthenticationServices services = AuthenticationServices();

  // Future<String?> showImagePath (String? uid) async{
  //   try{
  //     final result = await instance.child('profile_pictures/${uid}').list();
  //     final String imgPath = await result.items.first.getDownloadURL();
  //     // print(imgPath);
  //     return imgPath;
  //   }catch (e){
  //     print(e.toString());
  //   }
  //   return null;
  // }

  //Get data from the fireStore database
  Future<List<ProductProperties>?> getData() async {
    List<ProductProperties> productList = [];
    await docRef.get().then((value) {
      for (var snapshot in value.docs) {
        var data = snapshot.data();
        productList.add(ProductProperties(
          productId: snapshot.id,
          name: data['name'],
          numOfReviews: data['numberOfReviews'],
          price: data['price'],
          totalRating: data['totalRating'],
          imageUrl: data['imageUrl'].toList(),
          keyProperties: data['keyProperties'],
          description: data['description'],
          category: data['category'],
          subCategory: data['subCategory'],
          Quantity: data['quantity'],
        ));
      }
    }, onError: (e) => print(e.toString()));
    return productList;
  }

  // Get cart or wishlist data
  Stream<QuerySnapshot<Map<String, dynamic>>> getCartOrWishlistData(String uid, bool isCart) {
    String collectionPath = isCart ? 'cart' : 'wishlist';
    // List<ProductProperties> list = [];
    final pathRef = userRef
        .doc(uid)
        .collection(collectionPath);
    return pathRef.snapshots();
  }
  
  // Add an Item to cart or wishlist
  Future<void> addToCartOrWishlist(String uid, bool isCart, ProductProperties product) async{
    String collectionPath = isCart ? 'cart' : 'wishlist';
    try{
      userRef.doc(uid).collection(collectionPath)
          .add({
        'name' : product.name,
        'numberOfReviews' : product.numOfReviews,
        'price' : product.price,
        'totalRating' : product.totalRating,
        'imageUrl' : product.imageUrl,
        'keyProperties' : product.keyProperties,
        'description' : product.description,
        'category' : product.category,
        'subCategory' : product.subCategory,
        'quantity' : product.Quantity
      });
    } catch (error){

    }

  }

// Get product data based on category of the product
  Future<List<ProductProperties>> getCategoryData(String category) async {
    List<ProductProperties> productList = [];
    await docRef.where("category", isEqualTo: category).get().then((value) {
      for (var result in value.docs) {
        var data = result.data();
        productList.add(ProductProperties(
          productId: result.id,
          name: data['name'],
          numOfReviews: data['numberOfReviews'],
          price: data['price'],
          totalRating: data['totalRating'],
          imageUrl: data['imageUrl'].toList(),
          keyProperties: data['keyProperties'],
          description: data['description'],
          category: data['category'],
          subCategory: data['subCategory'],
          Quantity: data['quantity'],
        ));
      }
    }, onError: (e) => null);
    return productList;
  }

}
