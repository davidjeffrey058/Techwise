import 'package:flutter/material.dart';
import 'package:techwise_pub/Views/Authentication/login.dart';
import 'package:techwise_pub/Views/Authentication/sign_up.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({super.key});

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showLogin = true;
  toggle() {
    setState(() {
      showLogin = !showLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return showLogin ? Login(toggle: toggle) : SignUp(toggle: toggle);
  }
}
