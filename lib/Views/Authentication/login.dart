import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:techwise_pub/services/authenticaiton_services.dart';

import '../../States/mode_switch.dart';

class Login extends StatefulWidget {
  final void Function() toggle;

  Login({required this.toggle, Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late String loginEmail;
  late String loginPassword;
  late bool showPassword = true;
  late bool showLoading = false;

  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _emailController.addListener(() => setState(() {}));
    _passwordController.addListener(() => setState(() {}));
    _passwordFocusNode.addListener(() => setState(() {}));
    _emailFocusNode.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    ModeSwitch modeSwitch = Provider.of<ModeSwitch>(context);
    AuthenticationServices services = AuthenticationServices();

    //shows error message when login is unsuccessful
    showScaffoldMessenger(message) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Center(
              child: Text(
        message,
        style: TextStyle(color: Colors.white),
      ))));
    }

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SafeArea(
          child: Container(
            height: double.maxFinite,
            width: double.infinity,
            decoration: BoxDecoration(
                color: modeSwitch.isDark ? Colors.transparent : Colors.white),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    width: 104,
                    height: 104,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(
                          width: 5,
                          color: Color(0xffF2F2F2),
                          style: BorderStyle.solid),
                    ),
                  ),
                  Text(
                    'Welcome Back',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Sign in to continue',
                    style: TextStyle(color: Color(0xffC6C8C7), fontSize: 18),
                  ),
                  Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const SizedBox(
                              height: 43,
                            ),

                            //Email form field
                            Container(
                              decoration: BoxDecoration(
                                  boxShadow: _emailFocusNode.hasFocus
                                      ? [
                                          BoxShadow(
                                              color: Colors.grey,
                                              offset: Offset(0, 3),
                                              blurRadius: 6)
                                        ]
                                      : null,
                                  borderRadius: BorderRadius.circular(8)),
                              child: _buildEmail(),
                            ),
                            const SizedBox(
                              height: 21,
                            ),

                            //Password form field
                            Container(
                              decoration: BoxDecoration(
                                  boxShadow: _passwordFocusNode.hasFocus
                                      ? [
                                          BoxShadow(
                                              color: Colors.grey,
                                              offset: Offset(0, 3),
                                              blurRadius: 6)
                                        ]
                                      : null,
                                  borderRadius: BorderRadius.circular(8)),
                              child: _buildPassword(),
                            ),
                            TextButton(
                                onPressed: () {},
                                child: Text(
                                  'Forgot Password?',
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),

                            //The login button
                            Container(
                              width: double.infinity,
                              child: ElevatedButton(
                                  onPressed: showLoading
                                      ? null
                                      : () async {
                                          dynamic validation =
                                              _formKey.currentState;
                                          if (!validation.validate()) {
                                            return;
                                          }
                                          _formKey.currentState?.save();
                                          setState(() => showLoading = true);

                                          var result = await services
                                              .loginWithEmailAndPassword(
                                                  loginEmail, loginPassword);
                                          if (result == null) {
                                            showScaffoldMessenger(
                                                services.errorMessage);
                                          }

                                          setState(() => showLoading = false);
                                        },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      load(showLoading),
                                      SizedBox(
                                        width: showLoading ? 17 : 0,
                                      ),
                                      Text(
                                        'Login',
                                        style: TextStyle(
                                            fontSize: 17, color: Colors.white),
                                      ),
                                    ],
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.symmetric(vertical: 14),
                                  )),
                            ),
                          ],
                        ),
                      )),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                    child: Text('or', style: TextStyle(fontSize: 11)),
                  ),

                  //Continue with Google button
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 32),
                    child: ElevatedButton(
                        // Google Sign in Method
                        onPressed: () async {
                          customProgressIndicator();
                          final result = await services.signInWithGoogle();
                          Navigator.pop(context);
                          if (result == null) {
                            showScaffoldMessenger(services.errorMessage);
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Image.asset(
                              'images/google.png',
                              width: 35,
                              height: 35,
                            ),
                            SizedBox(
                              width: 14,
                            ),
                            Text(
                              'Continue with Google',
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                            )
                          ],
                        ),
                        style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.grey[500],
                            shape: RoundedRectangleBorder(
                                side: BorderSide(color: Colors.black, width: 1),
                                borderRadius: BorderRadius.circular(8)),
                            padding: EdgeInsets.symmetric(vertical: 7))),
                  ),
                  const SizedBox(
                    height: 21,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have an account? ',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                      InkWell(
                        onTap: widget.toggle,
                        child: Text(
                          'Create a new account',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).primaryColor),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmail() {
    return TextFormField(
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 0, color: Colors.white),
              borderRadius: BorderRadius.circular(8)),
          labelText: "Email",
          prefixIcon: Icon(Icons.email_outlined),
          suffixIcon: _emailController.text.isEmpty
              ? Container(
                  width: 0,
                )
              : IconButton(
                  onPressed: () {
                    _emailController.clear();
                  },
                  icon: Icon(Icons.close))),
      controller: _emailController,
      focusNode: _emailFocusNode,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      validator: (value) {
        if (value != null && value.isEmpty) {
          return "Email field is empty";
        }
        if (!RegExp(r"([a-z\d-.]+)@([a-z\d-]+)\.([a-z]{2,8})")
            .hasMatch(value!)) {
          return "Enter a valid email";
        }
        return null;
      },
      onSaved: (value) {
        loginEmail = value!;
      },
      onFieldSubmitted: (value) {
        FocusScope.of(context).requestFocus(_passwordFocusNode);
      },
    );
  }

  Widget _buildPassword() {
    return TextFormField(
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 0, color: Colors.white),
              borderRadius: BorderRadius.circular(8)),
          labelText: "Password",
          prefixIcon: Icon(Icons.lock_outline_rounded),
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                showPassword = !showPassword;
              });
            },
            icon: _passwordController.text.isEmpty
                ? Container(
                    width: 0,
                  )
                : Icon(showPassword
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined),
          )),
      textInputAction: TextInputAction.done,
      controller: _passwordController,
      focusNode: _passwordFocusNode,
      keyboardType: TextInputType.visiblePassword,
      obscureText: showPassword,
      validator: (value) {
        if (value != null && value.isEmpty) {
          return "Password field is empty";
        }
        if (value != null && value.length < 6) {
          return "Password must be at least 6 characters long";
        }
        return null;
      },
      onSaved: (value) {
        loginPassword = value!;
      },
    );
  }

  Widget load(value) {
    if (value) {
      return SpinKitCircle(
        size: 17,
        color: Colors.white,
      );
    } else {
      return SizedBox(
        width: 0,
      );
    }
  }

  customProgressIndicator() {
    showDialog(
      context: context,
      builder: ((context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          content: Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          ),
        );
      }),
    );
  }
}
