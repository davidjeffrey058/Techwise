import 'package:flutter/material.dart';

import '../../../Components/message.dart';

class OpenOrders extends StatelessWidget {
  const OpenOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return Message(
      imageUrl: 'images/order.png',
      title: 'You have no order in progress!',
      description: 'All your orders will be saved here for you to access their state anytime',
      button: ElevatedButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text(
          'Start Shopping'.toUpperCase(),
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
