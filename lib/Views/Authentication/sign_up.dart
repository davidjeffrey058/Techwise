import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:techwise_pub/services/authenticaiton_services.dart';

class SignUp extends StatefulWidget {
  final void Function() toggle;

  SignUp({required this.toggle, Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  late String fullName;
  late String email;
  late String phone;
  late String password;

  GlobalKey<FormState> _formKey = GlobalKey();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  FocusNode _nameNode = FocusNode();
  FocusNode _emailNode = FocusNode();
  FocusNode _phoneNode = FocusNode();
  FocusNode _passwordNode = FocusNode();

  bool showPassword = true;
  bool showLoading = false;

  @override
  void initState() {
    super.initState();
    _nameController.addListener(() => setState(() {}));
    _emailController.addListener(() => setState(() {}));
    _phoneController.addListener(() => setState(() {}));
    _passwordController.addListener(() => setState(() {}));
    _nameNode.addListener(() => setState(() {}));
    _emailNode.addListener(() => setState(() {}));
    _phoneNode.addListener(() => setState(() {}));
    _passwordNode.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    final AuthenticationServices services = AuthenticationServices();
    showScaffoldMessenger() {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(services.errorMessage)));
    }

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Create Account',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: _nameNode.hasFocus
                        ? Theme.of(context).primaryColor
                        : Colors.black),
              ),
              Text(
                'Create a new account',
                style: TextStyle(color: Color(0xffC6C8C7), fontSize: 18),
              ),
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.only(top: 28, right: 32, left: 32),
                  child: Column(
                    children: [
                      Container(
                          decoration: BoxDecoration(
                              boxShadow: _nameNode.hasFocus
                                  ? [
                                      BoxShadow(
                                          color: Colors.grey,
                                          offset: Offset(0, 3),
                                          blurRadius: 6)
                                    ]
                                  : null,
                              borderRadius: BorderRadius.circular(8)),
                          child: _buildName()),
                      SizedBox(
                        height: 21,
                      ),
                      Container(
                          decoration: BoxDecoration(
                              boxShadow: _emailNode.hasFocus
                                  ? [
                                      BoxShadow(
                                          color: Colors.grey,
                                          offset: Offset(0, 3),
                                          blurRadius: 6)
                                    ]
                                  : null,
                              borderRadius: BorderRadius.circular(8)),
                          child: _buildEmail()),
                      SizedBox(
                        height: 21,
                      ),
                      Container(
                          decoration: BoxDecoration(
                              boxShadow: _phoneNode.hasFocus
                                  ? [
                                      BoxShadow(
                                          color: Colors.grey,
                                          offset: Offset(0, 3),
                                          blurRadius: 6)
                                    ]
                                  : null,
                              borderRadius: BorderRadius.circular(8)),
                          child: _buildPhone()),
                      SizedBox(
                        height: 21,
                      ),
                      Container(
                          decoration: BoxDecoration(
                              boxShadow: _passwordNode.hasFocus
                                  ? [
                                      BoxShadow(
                                          color: Colors.grey,
                                          offset: Offset(0, 3),
                                          blurRadius: 6)
                                    ]
                                  : null,
                              borderRadius: BorderRadius.circular(8)),
                          child: _buildPassword()),
                      SizedBox(
                        height: 30,
                      ),

                      //Create account button
                      Container(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: showLoading
                              ? null
                              : () async {
                                  dynamic validation = _formKey.currentState;
                                  if (!validation.validate()) {
                                    return;
                                  }
                                  setState(() => showLoading = true);
                                  _formKey.currentState?.save();

                                  var result = await services
                                      .registerWithEmailAndPassword(
                                          email, password, fullName);

                                  if (result == null) {
                                    showScaffoldMessenger();
                                  }
                                  setState(() => showLoading = false);
                                },
                          child: showLoading
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SpinKitCircle(
                                      size: 17,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text('Creating Account')
                                  ],
                                )
                              : Text(
                                  'Create Account',
                                  style: TextStyle(fontSize: 17),
                                ),
                          style: ButtonStyle(
                              padding: MaterialStatePropertyAll(
                                  EdgeInsets.only(top: 14, bottom: 14)),
                              elevation: MaterialStatePropertyAll(0)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                child: Text('you can also', style: TextStyle(fontSize: 11)),
              ),

              //Sign in with google button
              Container(
                margin: EdgeInsets.symmetric(horizontal: 32),
                child: ElevatedButton(
                    onPressed: () {},
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
                          'Sign in with Google',
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
                        foregroundColor: Colors.grey,
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
                    'Already have an account? ',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  InkWell(
                    onTap: widget.toggle,
                    child: Text(
                      'Login',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).primaryColor),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 32,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildName() {
    return TextFormField(
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          labelText: "Full Name",
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 0, color: Colors.white),
              borderRadius: BorderRadius.circular(8)),
          prefixIcon: Icon(Icons.person_outline_rounded),
          suffixIcon: _nameController.text.isEmpty
              ? Container(
                  width: 0,
                )
              : IconButton(
                  onPressed: () {
                    _nameController.clear();
                  },
                  icon: Icon(Icons.close))),
      controller: _nameController,
      focusNode: _nameNode,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      textCapitalization: TextCapitalization.words,
      validator: (value) {
        if (value != null && value.isEmpty) {
          return "Name field is empty";
        }
        if (!RegExp(r"^[a-zA-Z]+(([',. -][a-zA-Z])?[a-zA-Z*]*$)")
            .hasMatch(value!)) {
          return "Enter a valid name";
        }
        return null;
      },
      onSaved: (value) {
        fullName = value!;
      },
      onFieldSubmitted: (value) {
        FocusScope.of(context).requestFocus(_emailNode);
      },
    );
  }

  Widget _buildEmail() {
    return TextFormField(
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          labelText: "Email",
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 0, color: Colors.white),
              borderRadius: BorderRadius.circular(8)),
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
      focusNode: _emailNode,
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
        email = value!;
      },
      onFieldSubmitted: (value) {
        FocusScope.of(context).requestFocus(_phoneNode);
      },
    );
  }

  Widget _buildPhone() {
    return TextFormField(
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          labelText: "Phone",
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 0, color: Colors.white),
              borderRadius: BorderRadius.circular(8)),
          prefixIcon: Icon(Icons.phone_outlined),
          suffixIcon: _phoneController.text.isEmpty
              ? Container(
                  width: 0,
                )
              : IconButton(
                  onPressed: () {
                    _phoneController.clear();
                  },
                  icon: Icon(Icons.close))),
      controller: _phoneController,
      focusNode: _phoneNode,
      keyboardType: TextInputType.phone,
      textInputAction: TextInputAction.next,
      validator: (value) {
        if (value != null && value.isEmpty) {
          return "Phone field is empty";
        }
        return null;
      },
      onSaved: (value) {
        phone = value!;
      },
      onFieldSubmitted: (value) {
        FocusScope.of(context).requestFocus(_passwordNode);
      },
    );
  }

  Widget _buildPassword() {
    return TextFormField(
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          labelText: "Password",
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 0, color: Colors.white),
              borderRadius: BorderRadius.circular(8)),
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
      textInputAction: TextInputAction.go,
      controller: _passwordController,
      focusNode: _passwordNode,
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
        password = value!;
      },
    );
  }
}
