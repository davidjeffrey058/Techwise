import 'package:flutter/material.dart';
import 'package:techwise_pub/Views/Components/message.dart';

class ActiveOrInactive extends StatelessWidget {
  const ActiveOrInactive({super.key});

  @override
  Widget build(BuildContext context) {
    return Message(
      imageUrl: 'images/coupons.png',
      title: 'You currently have no available voucher',
      description: 'All your Vouchers and coupons will be displayed here',
      button: ElevatedButton(
        onPressed: (){},
        child: Text(
          'CONTINUE SHOPPING',
          style: TextStyle(
            color: Colors.white
          ),
        ),
      ),
    );
  }
}
