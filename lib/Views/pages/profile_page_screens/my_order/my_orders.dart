import 'package:flutter/material.dart';
import 'package:techwise_pub/Views/pages/profile_page_screens/my_order/open_orders.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({super.key});

  @override
  State<MyOrders> createState() => _MyOrdersState();
}
late TabController tabController;

class _MyOrdersState extends State<MyOrders> with SingleTickerProviderStateMixin{
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this, initialIndex: 0);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Orders'),
        bottom: TabBar(
          controller: tabController,
          tabs: [
            Tab(
              text: 'Open Orders',
            ),
            Tab(
              text: 'Closed Orders',
            )
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          OpenOrders(),
          Text('closed orders')
        ],
      ),
    );
  }
}
