import 'package:flutter/material.dart';
import 'package:techwise_pub/Views/Components/message.dart';

class RecentlyViewed extends StatefulWidget {
  const RecentlyViewed({super.key});

  @override
  State<RecentlyViewed> createState() => _RecentlyViewedState();
}

class _RecentlyViewedState extends State<RecentlyViewed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recently Viewed'),
      ),
      body: Message(
        imageUrl: 'images/order.png',
        title: 'No Recently Viewed Products',
        description: 'You do not have any recently viewed products at the moment',
      ),
    );
  }
}
