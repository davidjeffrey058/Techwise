import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:techwise_pub/Models/product_info.dart';

class DataServices {
  final docRef = FirebaseFirestore.instance.collection('products');
  final instance = FirebaseStorage.instance.ref();

  List<ProductProperties> productList = [];

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
            Quantity: data['quantity']));
      }
    }, onError: (e) => print(e.toString()));
    return productList;
  }
}
