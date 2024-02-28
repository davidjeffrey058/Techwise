import 'package:flutter/material.dart';
import 'package:techwise_pub/Views/pages/profile_page_screens/vouchers/active_or_inactive.dart';

class Vouchers extends StatefulWidget{
  @override
  State<Vouchers> createState() => _VoucherState();
}
late TabController tabController;

class _VoucherState extends State<Vouchers> with SingleTickerProviderStateMixin{
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this, initialIndex: 0);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vouchers'),
        bottom: TabBar(
          controller: tabController,
          tabs: [
            Tab(
              text: 'Active',
            ),
            Tab(
              text: 'Inactive',
            )
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          ActiveOrInactive(),
          ActiveOrInactive()
        ],
      ),
    );
  }

}
