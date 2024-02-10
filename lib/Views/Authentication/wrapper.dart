import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techwise_pub/Views/Authentication/authenticate.dart';
import 'package:techwise_pub/Models/user_properties.dart';
import 'package:techwise_pub/Views/pages/home.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProperties?>(context);

    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
