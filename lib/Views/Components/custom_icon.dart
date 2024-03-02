import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techwise_pub/Models/user_properties.dart';
import 'package:techwise_pub/services/data_services.dart';

class CustomIcon extends StatelessWidget {
  final String iconName;
  final double? width;
  final double? height;
  final Color? color;
  final bool isColored;

  const CustomIcon(
      {super.key,
      required this.iconName,
      this.width,
      this.height,
      this.color,
      this.isColored = true});

  @override
  Widget build(BuildContext context) {

    Color? iconColor() {
      if(!isColored && color != null){
        return color;
      }
      return null;
    }

    return SizedBox(
      width: width ?? 24,
      height: height ?? 24,
      child: Image(image: AssetImage('images/icons/$iconName'), color: iconColor(), fit: BoxFit.contain,),
    );
  }
}


class FavoriteIcon extends StatelessWidget {
  final String productId;
  final bool isIconButton;
  const FavoriteIcon({super.key, this.isIconButton = false, required this.productId});

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<UserProperties?>(context);
    bool isFav = false;

    if( user != null){
      return StreamBuilder(
        stream: DataServices().getCartOrWishlistData(user.uid, false),
        builder: (context, snapshot){

          if (snapshot.hasData && snapshot.data != null){

            for ( var value in snapshot.data!.docs){
              if(productId == value.id){
                isFav = true;
                break;
              }
            }
            return favIcon(isFavorite: isFav);
          } else {
            return favIcon(isFavorite: isFav);
          }
        },
      );
    } else {
      return favIcon();
    }
  }
  Widget favIcon({
    bool isFavorite = false
}){
    if (isIconButton){
      return IconButton(
        onPressed: () {},
        icon: Icon(
          isFavorite ? Icons.favorite : Icons.favorite_border_rounded,
          color: Colors.red,
        ),
        style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(Colors.white),
            elevation: MaterialStatePropertyAll(2)),
      );
    } else {
      return InkWell(
        onTap: (){},
        child: Icon(isFavorite ? Icons.favorite : Icons.favorite_border_rounded, color: Colors.red,),
      );
    }
  }
}

