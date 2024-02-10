import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:techwise_pub/Controller/Cubit/theme_switch.dart';
import 'package:techwise_pub/Models/option.dart';
import 'package:techwise_pub/Models/user_properties.dart';
import 'package:techwise_pub/services/authenticaiton_services.dart';
import '../Components/option_layout.dart';

class Profile extends StatefulWidget {
  Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  List<Options> options = [
    Options(option: 'My Profile'),
    Options(option: 'Change Password'),
    Options(option: 'Payment Settings'),
    Options(option: 'Notifications'),
    Options(option: 'About Us'),
    Options(option: 'Contact Us'),
    Options(option: 'Game')
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProperties>(context);
    AuthenticationServices services = AuthenticationServices();
    final toggleMode = BlocProvider.of<ThemeSwitch>(context);
    // final profileUrl = DataServices().showImagePath(user.uid);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Stack(children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                    // colorPalette.mainBlue,
                    // colorPalette.mainBlueLt
                    Theme.of(context).primaryColor,
                    Colors.deepPurple
                  ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 41,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(width: 3, color: Colors.white),
                            color: Colors.white),

                        //Builds the profile image widget
                        // child:
                        child: CircleAvatar(
                          // backgroundColor: Colors.white,
                          backgroundImage: AssetImage('images/grey_person.png'),
                          radius: 64,
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Text(
                        user.fullName ?? 'User Name',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1),
                      ),
                      Text(
                        user.email ?? 'User Email',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            letterSpacing: 1),
                      ),
                      SizedBox(
                        height: 31,
                      )
                    ],
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: IconButton(
                      icon: Icon(
                        Icons.sunny,
                        color: Colors.white,
                      ),
                      onPressed: () => toggleMode.switchMode()),
                )
              ]),
              Container(
                margin: const EdgeInsets.fromLTRB(19, 15, 19, 32),
                decoration: const BoxDecoration(
                  // color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  // boxShadow: [
                  //   BoxShadow(
                  //     color: Colors.black12,
                  //     spreadRadius: 2,
                  //     blurRadius: 6,
                  //     offset: Offset(1, 2)
                  //   )
                  // ]
                ),
                child: Column(
                  children:
                      options.map((e) => OptionLayout(options: e)).toList(),
                ),
                // child: ListView.builder(
                //   itemCount: options.length,
                //   itemBuilder: (BuildContext context, int index){
                //     return Padding(
                //       padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
                //       child: ListTile(
                //         title: Text(
                //           options[index].option,
                //         ),
                //         trailing: Icon(Icons.navigate_next),
                //       )
                //     );
                //   },
                // )
              ),
              Padding(
                padding: const EdgeInsets.only(left: 95, right: 95, bottom: 30),
                child: ElevatedButton.icon(
                  style: const ButtonStyle(
                    padding: MaterialStatePropertyAll(
                        EdgeInsets.only(top: 8, bottom: 8)),
                  ),
                  onPressed: () async {
                    await services.logout();
                  },
                  icon: const Icon(Icons.logout),
                  label: Text(
                    'Sign Out',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
