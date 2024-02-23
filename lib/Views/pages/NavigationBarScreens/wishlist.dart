import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:techwise_pub/Models/user_properties.dart';
import 'package:techwise_pub/Views/Components/layouts.dart';
import 'package:techwise_pub/services/data_services.dart';

class WishList extends StatefulWidget {
  const WishList({Key? key}) : super(key: key);

  @override
  State<WishList> createState() => _WishListState();
}

class _WishListState extends State<WishList> {


  Layouts layouts = Layouts();
  Future wishlist(String uid) async{
    // List<ProductProperties> list = [];
    final ref = FirebaseFirestore.instance.collection('Users').doc(uid).collection('wishlist');
    await ref.get().then((value){
      return value.docs;
    });

  }

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<UserProperties>(context);
    final result = wishlist(user.uid);
    print(result);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Wishlist',
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
        // backgroundColor: Colors.red,
        elevation: 0,
      ),
      body: StreamBuilder(
        stream: DataServices().getCartOrWishlistData(user.uid, false),
        builder: (context, snapshot){
          final data = snapshot.data;
          print(snapshot.data);
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator());
          }
          else if(snapshot.hasData){

              return ListView.builder(
                itemCount: data!.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {},
                    child: Container(
                      margin: EdgeInsets.fromLTRB(11, 11, 11, 0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          boxShadow: [
                            BoxShadow(
                                color: Color(0xffE4E4E4),
                                blurRadius: 3,
                                spreadRadius: 1,
                                offset: Offset(0, 3))
                          ]),
                      padding: EdgeInsets.symmetric(vertical: 7, horizontal: 9),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Image(
                                height: 66,
                                width: 66,
                                image: NetworkImage(data[index].imageUrl.first)
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data[index].name,
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[800]),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    NumberFormat.currency(symbol: '₵')
                                        .format(data[index].price),
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context).primaryColor),
                                  )
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: 13,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton.icon(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                label: Text(
                                  'REMOVE',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall
                                      ?.copyWith(color: Colors.red),
                                ),
                                style: ButtonStyle(
                                    backgroundColor:
                                    MaterialStatePropertyAll(Colors.transparent),
                                    elevation: MaterialStatePropertyAll(0),
                                    overlayColor:
                                    MaterialStatePropertyAll(Colors.red[100])),
                              ),
                              ElevatedButton(
                                onPressed: () {},
                                child: Text(
                                  'ADD TO CART',
                                  style: Theme.of(context).textTheme.labelSmall,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              );

          }
          else{
            return layouts.emptyPage('Sign in to access wishlist');
          }
        },
      )
    );
  }

}
