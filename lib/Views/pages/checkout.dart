import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CheckOut extends StatefulWidget {
  const CheckOut({Key? key}) : super(key: key);

  @override
  State<CheckOut> createState() => _CheckOutState();
}
dynamic data = [];

class _CheckOutState extends State<CheckOut> {
  @override
  Widget build(BuildContext context) {

    data = ModalRoute.of(context)?.settings.arguments;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Checkout'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Your total'),
            Text(
              NumberFormat.currency(symbol: '₵').format(data['total'])
            ),
          ],
        ),
      ),
    );
  }
}
